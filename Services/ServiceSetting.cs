using System.Text.Json;
using SQLite;
using Dapper;
using FWSAPP.Models;
using Microsoft.Data.SqlClient;
using Microsoft.Maui.Storage;
using System.Diagnostics;

namespace FWSAPP.Services;

public static class ServiceSetting
{
    private static readonly string LocalSettingPath = Path.Combine(FileSystem.AppDataDirectory, "appsetting.json");    
    public static readonly string LocalDbPath = Path.Combine(FileSystem.AppDataDirectory, "ID.db");
    private const string DefaultUrl = "https://125.227.73.103:9253/api/appsetting.json";

    public static async Task<bool> UpdateAppSettingAsync(bool isStartup = false)
    {
        int errorCount = 0;
        string server = Preferences.Get("server", "");
        string settingUrl = isStartup || string.IsNullOrEmpty(server)
            ? DefaultUrl
            : $"{server}/api/appsetting.json";

        using var client = new HttpClient { Timeout = TimeSpan.FromSeconds(5) };

        if (isStartup)
        {
            try
            {
                var json = await client.GetStringAsync(settingUrl);
                File.WriteAllText(LocalSettingPath, json);

                var jsonDoc = JsonDocument.Parse(json);
                Preferences.Set("server", jsonDoc.RootElement.GetProperty("server").GetString());

                return true;
            }
            catch
            {
                await MainThread.InvokeOnMainThreadAsync(async () =>
                {
                    var page = Application.Current?.MainPage ?? new ContentPage();
                    await page.DisplayAlert("錯誤", "伺服器異常，請重啟APP", "確定");
                });
                return false;
            }
        }

        while (errorCount < 5)
        {
            try
            {
                var json = await client.GetStringAsync(settingUrl);
                File.WriteAllText(LocalSettingPath, json);

                var jsonDoc = JsonDocument.Parse(json);
                Preferences.Set("server", jsonDoc.RootElement.GetProperty("server").GetString());

                return true;
            }
            catch
            {
                errorCount++;
                await Task.Delay(5000);
            }
        }

        await MainThread.InvokeOnMainThreadAsync(async () =>
        {
            var page = Application.Current?.MainPage ?? new ContentPage();
            await page.DisplayAlert("錯誤", "連線失敗!", "OK");
        });

        if (File.Exists(LocalSettingPath))
            File.Delete(LocalSettingPath);

        while (true)
        {
            try
            {
                var json = await client.GetStringAsync(DefaultUrl);
                File.WriteAllText(LocalSettingPath, json);

                var jsonDoc = JsonDocument.Parse(json);
                Preferences.Set("server", jsonDoc.RootElement.GetProperty("server").GetString());

                return true;
            }
            catch
            {
                await Task.Delay(5000);
            }
        }
    }

    public static async Task CheckAppVersionAsync()
    {
        try
        {
            var jsonText = await File.ReadAllTextAsync(LocalSettingPath);
            var jsonDoc = JsonDocument.Parse(jsonText);

            var latestVersion = jsonDoc.RootElement.GetProperty("latestApkVersion").GetString();
            var apkDownloadUrl = $"{Preferences.Get("server", "")}/api/fws.apk";

            if (string.IsNullOrEmpty(latestVersion) || string.IsNullOrEmpty(apkDownloadUrl))
                return;

            var currentVersion = AppInfo.VersionString;

            if (new Version(latestVersion) > new Version(currentVersion))
            {
                await MainThread.InvokeOnMainThreadAsync(async () =>
                {
                    var page = Application.Current?.MainPage;
                    if (page != null)
                    {
                        bool result = await page.DisplayAlert(
                            "發現新版本",
                            $"最新版本：{latestVersion}\n當前版本：{currentVersion}\n\n是否立即更新？",
                            "立即更新", "取消");

                        if (result)
                            await DownloadAndInstallApkAsync(apkDownloadUrl);
                    }
                });
            }
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"檢查版本錯誤: {ex.Message}");
        }
    }

    public static async Task DownloadAndInstallApkAsync(string apkDownloadUrl)
    {
        try
        {
            var filePath = Path.Combine(FileSystem.AppDataDirectory, "update.apk");

            using var client = new HttpClient();
            var apkBytes = await client.GetByteArrayAsync(apkDownloadUrl);
            await File.WriteAllBytesAsync(filePath, apkBytes);

#if ANDROID
        Platforms.Android.ApkInstaller.InstallApk(filePath);
#endif
        }
        catch (Exception ex)
        {
            Debug.WriteLine($"APK下載或安裝失敗: {ex.Message}");
            await MainThread.InvokeOnMainThreadAsync(async () =>
            {
                await Application.Current.MainPage.DisplayAlert("錯誤", $"下載或安裝失敗：{ex.Message}", "OK");
            });
        }
    }

    // 🔸從SQL下載資料到本地SQLite
    public static async Task DownloadIDDatabaseAsync()
    {
        if (!await UpdateAppSettingAsync())
            throw new Exception("設定更新失敗，無法繼續下載資料庫。");

        // 取得 SQL Server 連線字串
        var json = await File.ReadAllTextAsync(LocalSettingPath);
        var jsonDoc = JsonDocument.Parse(json);
        var sqlConnStr = jsonDoc.RootElement
            .GetProperty("ConnectionStrings")
            .GetProperty("FWS-ID")
            .GetString();

        if (string.IsNullOrEmpty(sqlConnStr))
            throw new Exception("未設定SQL連線字串!");

        try
        {
            // 連線SQL Server，抓取id資料表
            using var sqlConn = new SqlConnection(sqlConnStr);
            var sql = @"
                      SELECT 
    ID,
    ISNULL(NULLIF(LTRIM(RTRIM(姓名)), ''), '姓名') AS 姓名,
    ISNULL(NULLIF(LTRIM(RTRIM(帳號)), ''), '帳號') AS 帳號,
    ISNULL(NULLIF(LTRIM(RTRIM(末四碼)), ''), '末四碼') AS 末四碼,
    ISNULL(NULLIF(LTRIM(RTRIM(等級)), ''), '1') AS 等級,
    ISNULL(狀態, 0) AS 狀態,
    ISNULL(電話, '') AS 電話,
    ISNULL(備註, '') AS 備註,
    ISNULL(備註修改者, '') AS 備註修改者,
    ISNULL(CONVERT(varchar, 備註修改時間, 120), '') AS 備註修改時間
FROM dbo.id";
            var data = await sqlConn.QueryAsync<IDModel>(sql);

            // 寫入SQLite
            var sqliteConn = new SQLiteAsyncConnection(LocalDbPath);
            await sqliteConn.CreateTableAsync<IDModel>();

            // 先清除舊資料
            await sqliteConn.DeleteAllAsync<IDModel>();

            // 寫入新資料
            await sqliteConn.InsertAllAsync(data);
        }
        catch (Exception ex)
        {
            throw new Exception($"資料庫同步失敗: {ex.Message}");
        }
    }

    // 🔸 新增：載入 SQLite DB 的方法
    public static async Task<List<IDModel>> LoadMembersAsync()
    {
        var connection = new SQLiteAsyncConnection(LocalDbPath);
        return await connection.Table<IDModel>().ToListAsync();
    }
}

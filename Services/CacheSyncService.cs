using System.Diagnostics;
using System.Timers;
using FWSAPP.Services;

public class CacheSyncService
{
    private readonly System.Timers.Timer syncTimer;

    public CacheSyncService()
    {
        syncTimer = new System.Timers.Timer(5 * 60 * 1000);
        syncTimer.Elapsed += async (s, e) => await AutoUpdateAsync();
        syncTimer.Start();
    }

    public async Task AutoUpdateAsync()
    {
        try
        {
            await ServiceSetting.UpdateAppSettingAsync();
            await ServiceSetting.DownloadIDDatabaseAsync();
            await ServiceSetting.CheckAppVersionAsync();

        }
        catch (Exception ex)
        {
            Debug.WriteLine("自動更新失敗: " + ex.Message);
        }
    }
}

#pragma warning disable CA1416 // 驗證平台相容性
using Android.App;
using Android.Content;
using Android.OS;
using AndroidX.Core.Content;
using Android.Net;
using Application = Android.App.Application;
using Uri = Android.Net.Uri;

namespace FWSAPP.Platforms.Android
{
    public class ApkInstaller
    {
        public static async Task DownloadAndInstallApkAsync(string apkDownloadUrl)
        {
            try
            {
                var apkPath = Path.Combine(FileSystem.CacheDirectory, "com.companyname.fwsapp-Signed.apk");
                if (File.Exists(apkPath))
                    File.Delete(apkPath);

                var context = Platform.CurrentActivity ?? Application.Context;

                var downloadDir = global::Android.OS.Environment.GetExternalStoragePublicDirectory(global::Android.OS.Environment.DirectoryDownloads);
                if (downloadDir == null)
                    throw new InvalidOperationException("找不到 Download 資料夾");

                var filePath = System.IO.Path.Combine(downloadDir.AbsolutePath, "com.companyname.fwsapp-Signed.apk");

                using var client = new HttpClient();
                var apkBytes = await client.GetByteArrayAsync(apkDownloadUrl);
                await System.IO.File.WriteAllBytesAsync(filePath, apkBytes);

                System.Diagnostics.Debug.WriteLine($"APK 下載完成: {filePath}, 大小: {apkBytes.Length} bytes");

                InstallApk(filePath);
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine($"APK 下載或安裝失敗: {ex.Message}");
                await Microsoft.Maui.ApplicationModel.MainThread.InvokeOnMainThreadAsync(async () =>
                {
                    var mainPage = Microsoft.Maui.Controls.Application.Current?.MainPage;
                    if (mainPage != null)
                        await mainPage.DisplayAlert("錯誤", $"下載或安裝失敗：{ex.Message}", "OK");
                });
            }
        }

        public static void InstallApk(string filePath)
        {
            var file = new Java.IO.File(filePath);
            var context = Platform.CurrentActivity ?? Application.Context;

            Uri? fileUri;

            if (Build.VERSION.SdkInt >= BuildVersionCodes.N)
            {
                fileUri = AndroidX.Core.Content.FileProvider.GetUriForFile(
                    context,
                    $"{context.PackageName}.fileprovider",
                    file);

                var intent = new Intent(Intent.ActionView);
                intent.SetDataAndType(fileUri, "application/vnd.android.package-archive");
                intent.AddFlags(ActivityFlags.NewTask | ActivityFlags.GrantReadUriPermission);
                context.StartActivity(intent);
            }
            else
            {
                fileUri = Uri.FromFile(file)!;

                var intent = new Intent(Intent.ActionView);
                intent.SetDataAndType(fileUri, "application/vnd.android.package-archive");
                intent.SetFlags(ActivityFlags.NewTask);
                context.StartActivity(intent);
            }
        }
    }
}

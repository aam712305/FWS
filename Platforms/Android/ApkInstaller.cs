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

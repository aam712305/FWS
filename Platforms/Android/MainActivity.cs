using Android.App;
using Android.Content.PM;
using Android.OS;
using Android.Views;
using AndroidX.Core.App;
using AndroidX.Core.Content;
using Android;

namespace FWSAPP.Platforms.Android;

[Activity(Theme = "@style/Maui.SplashTheme", MainLauncher = true,
    ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
public class MainActivity : MauiAppCompatActivity
{
    protected override void OnCreate(Bundle? savedInstanceState)
    {
        base.OnCreate(savedInstanceState);

        var permissions = new List<string>
    {
        Manifest.Permission.AccessFineLocation,
        Manifest.Permission.AccessWifiState,
    };

        // ⚠️ 改為 BuildVersionCodes.S (Android 12) 
        if (Build.VERSION.SdkInt >= BuildVersionCodes.S)
        {
            permissions.Add(Manifest.Permission.NearbyWifiDevices);
        }

        var notGrantedPermissions = permissions
            .Where(p => ContextCompat.CheckSelfPermission(this, p) != Permission.Granted)
            .ToArray();

        if (notGrantedPermissions.Any())
        {
            ActivityCompat.RequestPermissions(this, notGrantedPermissions, 0);
        }
    }

}

using Android.Content;
using Android.Net.Wifi;
using Android.OS;
using Android;
using Android.Content.PM;
using AndroidX.Core.Content;
using System.Linq;

namespace FWSAPP.Platforms.Android
{
    public class WifiService : IWifiService
    {
        public string GetCurrentWifiName()
        {
            var context = global::Android.App.Application.Context;

            if (ContextCompat.CheckSelfPermission(context, Manifest.Permission.AccessFineLocation) != Permission.Granted ||
                ContextCompat.CheckSelfPermission(context, Manifest.Permission.NearbyWifiDevices) != Permission.Granted)
            {
                return "無權限";
            }

            WifiManager wifiManager = (WifiManager)context.GetSystemService(Context.WifiService);

            if (!wifiManager.IsWifiEnabled)
                return "WiFi未啟用";

            if (Build.VERSION.SdkInt >= BuildVersionCodes.S)
            {
                // 最新API需要主動掃描並匹配當前連線BSSID
                var wifiInfo = wifiManager.ConnectionInfo;
                if (wifiInfo == null || wifiInfo.BSSID == null)
                    return "<unknown ssid>";

                var scanResults = wifiManager.ScanResults;
                if (scanResults != null)
                {
                    var currentNetwork = scanResults.FirstOrDefault(x => x.Bssid.Equals(wifiInfo.BSSID, System.StringComparison.OrdinalIgnoreCase));
                    if (currentNetwork != null)
                    {
                        return currentNetwork.Ssid;
                    }
                    else
                    {
                        return "<未找到匹配網路>";
                    }
                }
                else
                {
                    return "<掃描結果為空>";
                }
            }
            else
            {
                // 舊版Android (<31)
                var wifiInfo = wifiManager.ConnectionInfo;
                if (wifiInfo != null && !string.IsNullOrEmpty(wifiInfo.SSID))
                    return wifiInfo.SSID.Trim('"');
                else
                    return "<unknown ssid>";
            }
        }
    }
}
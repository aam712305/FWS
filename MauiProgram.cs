using FWSAPP.Services;
using Microsoft.Extensions.Logging;
#if ANDROID
using FWSAPP.Platforms.Android; // ⚠️ 加上這行，明確引入你的WifiService
#endif

namespace FWSAPP;

public static class MauiProgram
{
    public static MauiApp CreateMauiApp()
    {
        var builder = MauiApp.CreateBuilder();
        builder
            .UseMauiApp<App>()
            .ConfigureFonts(fonts =>
            {
                fonts.AddFont("OpenSans-Regular.ttf", "OpenSansRegular");
                fonts.AddFont("OpenSans-Semibold.ttf", "OpenSansSemibold");
            });

        builder.Logging.AddDebug();

#if ANDROID
        builder.Services.AddTransient<IWifiService, WifiService>();
#endif

        builder.Services.AddSingleton<CacheSyncService>();
        builder.Services.AddTransient<SettingsPage>();
        builder.Services.AddSingleton<NoteService>();
        builder.Services.AddTransient<IDPage>();
        return builder.Build();
    }
}

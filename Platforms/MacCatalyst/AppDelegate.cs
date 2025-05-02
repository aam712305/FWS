using Foundation;

namespace FWSAPP
{
    [Register("AppDelegate")]
    public class AppDelegate : MauiUIApplicationDelegate
    {
        protected override MauiApp CreateMauiApp() => Member.CreateMauiApp();
    }
}

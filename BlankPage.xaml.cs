namespace FWSAPP;

public partial class BlankPage : ContentPage
{
    public BlankPage()
    {
        InitializeComponent();
    }

    protected override async void OnAppearing()
    {
        base.OnAppearing();

        var currentUser = Preferences.Get("currentUser", "");

        if (string.IsNullOrEmpty(currentUser))
        {
            var wifiService = Application.Current?.Handler?.MauiContext?.Services.GetService<IWifiService>();
            if (wifiService == null)
            {                
                return;
            }

            var idPage = new IDPage(wifiService);

            // 直接觸發登入邏輯
            await idPage.TriggerLoginAsync();
        }
        else
        {
            var wifiService = Application.Current?.Handler?.MauiContext?.Services.GetService<IWifiService>();
            if (wifiService == null)
            {                
                return;
            }

            Application.Current.MainPage = new NavigationPage(new IDPage(wifiService));
        }

    }
}

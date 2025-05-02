using System.Text.Json;
using System.Text.Json.Nodes;

namespace FWSAPP;

public partial class SettingsPage : ContentPage
{
    JsonNode? jsonRoot; // 修正為可為null型別
    private readonly IWifiService _wifiService;

    public SettingsPage(IWifiService wifiService)
    {
        InitializeComponent();
        _wifiService = wifiService ?? throw new ArgumentNullException(nameof(wifiService));
        storePicker.SelectedIndexChanged += StorePicker_SelectedIndexChanged;
    }

    protected override void OnAppearing()
    {
        base.OnAppearing();

        serverLabel.Text = Preferences.Get("server", "");
        
        // 伺服器APK版本
        apkLabel.Text = $"線上版本：{Preferences.Get("latestApkVersion", "未知")}";

        // 當前APK版本
        currentLabel.Text = $"當前版本：{AppInfo.VersionString}";

        LoadSettingsJson();
        
        wifiLabel.Text = _wifiService.GetCurrentWifiName();                
        userLabel.Text = Preferences.Get("currentUser", "");
        permissionLabel.Text = Preferences.Get("currentPermission", "");

        if (jsonRoot?["stores"] == null)
            return;

        var savedStore = Preferences.Get("SelectedStore", "");
        var savedArea = Preferences.Get("SelectedArea", "");

        var storeList = (List<string>)storePicker.ItemsSource;

        if (storeList != null && !string.IsNullOrEmpty(savedStore) && storeList.Contains(savedStore))
        {
            storePicker.SelectedItem = savedStore;

            var areas = jsonRoot["stores"]?
                .AsArray()
                .Where(store => store?["storeName"]?.ToString() == savedStore)
                .Select(store => store?["storeArea"]?.ToString() ?? "")
                .Distinct()
                .ToList() ?? [];

            areas.Insert(0, "");
            areaPicker.ItemsSource = areas;

            areaPicker.SelectedItem = areas.Contains(savedArea) ? savedArea : "";
        }
        else
        {
            storePicker.SelectedIndex = 0;
            areaPicker.ItemsSource = new List<string> { "" };
            areaPicker.SelectedIndex = 0;
        }
    }

    private async void OnLogoutButtonClicked(object? sender, EventArgs e)
    {
        bool confirm = await DisplayAlert("確認登出", "確定要登出嗎？", "是", "否");
        if (confirm)
        {
            Preferences.Remove("currentUser");
            Preferences.Remove("currentPermission");

            userLabel.Text = "";
            permissionLabel.Text = "";

            if (sender is Button logoutButton && Content is Layout layout)
                layout.Children.Remove(logoutButton);
            // 建立全新 BlankPage 實例以解決 parent 問題
            MainThread.BeginInvokeOnMainThread(() =>
            {
                Application.Current.MainPage = new NavigationPage(new BlankPage());
            });
        }
    }

    private void LoadSettingsJson()
    {
        var settingPath = Path.Combine(FileSystem.AppDataDirectory, "appsetting.json");

        if (!File.Exists(settingPath))
        {
            MainThread.BeginInvokeOnMainThread(() =>
                DisplayAlert("錯誤", "找不到設定檔案 appsetting.json", "OK"));
            return;
        }

        try
        {
            var jsonText = File.ReadAllText(settingPath);
            jsonRoot = JsonNode.Parse(jsonText);

            if (jsonRoot?["stores"] == null)
                throw new InvalidOperationException("JSON內沒有stores節點");

            // ⬅︎ 新增：把 latestApkVersion 寫入 Preferences
            var fileVer = jsonRoot?["latestApkVersion"]?.ToString() ?? "";
            Preferences.Set("latestApkVersion", fileVer);

            var stores = jsonRoot?["stores"]?
                .AsArray()
                .Select(store => store?["storeName"]?.ToString() ?? "")
                .Distinct()
                .ToList() ?? [];

            stores.Insert(0, "");
            storePicker.ItemsSource = stores;
            storePicker.SelectedIndex = 0;

            areaPicker.ItemsSource = new List<string> { "" };
            areaPicker.SelectedIndex = 0;
        }
        catch (Exception ex)
        {
            MainThread.BeginInvokeOnMainThread(() =>
                DisplayAlert("JSON讀取錯誤", ex.Message, "OK"));
        }
    }

    private void StorePicker_SelectedIndexChanged(object? sender, EventArgs e) // 修改為object?
    {
        var selectedStore = storePicker.SelectedItem as string;

        if (jsonRoot == null || string.IsNullOrEmpty(selectedStore))
        {
            areaPicker.ItemsSource = new List<string> { "" };
            areaPicker.SelectedIndex = 0;
            return;
        }

        var areas = jsonRoot["stores"]?
            .AsArray()
            .Where(store => store?["storeName"]?.ToString() == selectedStore)
            .Select(store => store?["storeArea"]?.ToString() ?? "")
            .Distinct()
            .ToList() ?? [];

        areas.Insert(0, "");
        areaPicker.ItemsSource = areas;
        areaPicker.SelectedIndex = 0;
    }

    private async void OnSaveSettingsClicked(object sender, EventArgs e)
    {
        Preferences.Set("SelectedStore", storePicker.SelectedItem?.ToString() ?? "");
        Preferences.Set("SelectedArea", areaPicker.SelectedItem?.ToString() ?? "");

        await DisplayAlert("儲存設定", "您的設定已經成功儲存。", "OK");
    }
}

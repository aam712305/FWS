using System.Diagnostics;
using System.Text.Json;
using FWSAPP.Services;
using Microsoft.Maui.Controls;

namespace FWSAPP
{
    public partial class App : Application
    {
        private static readonly string LocalSettingPath = Path.Combine(FileSystem.AppDataDirectory, "appsetting.json");

        public App()
        {
            InitializeComponent();
        }

        protected override Window CreateWindow(IActivationState? activationState)
        {
            var loadingPage = CreateLoadingPage;
            var window = new Window(new NavigationPage(new BlankPage()));
            LoadSettingsAsync(window, loadingPage);

            return window;
        }

        private ContentPage CreateLoadingPage
        {
            get
            {
                var continueButton = new Button { Text = "繼續" };
                var cancelButton = new Button { Text = "取消" };

                var buttonsLayout = new Grid
                {
                    ColumnDefinitions =
        {
            new ColumnDefinition(GridLength.Star),
            new ColumnDefinition(GridLength.Star)
        },
                    ColumnSpacing = 10
                };

                buttonsLayout.Add(continueButton, 0);
                buttonsLayout.Add(cancelButton, 1);

                var loadingLayout = new Grid
                {
                    RowDefinitions =
        {
            new RowDefinition(GridLength.Auto),
            new RowDefinition(GridLength.Auto),
            new RowDefinition(GridLength.Auto),
        },
                    RowSpacing = 20,
                    VerticalOptions = LayoutOptions.Center,
                    HorizontalOptions = LayoutOptions.Center
                };

                loadingLayout.Add(new ActivityIndicator { IsRunning = true, HorizontalOptions = LayoutOptions.Center }, 0, 0);
                loadingLayout.Add(new Label { Text = "正在載入設定...", HorizontalOptions = LayoutOptions.Center }, 0, 1);
                loadingLayout.Add(buttonsLayout, 0, 2);

                var loadingPage = new ContentPage { Content = loadingLayout };

                continueButton.Clicked += async (_, _) =>
                {
                    var currentApp = Application.Current;
                    var currentWindow = currentApp?.Windows.FirstOrDefault();

                    if (currentWindow is not null)
                    {
                        LoadSettingsAsync(currentWindow, loadingPage);
                    }
                    else
                    {
                        await loadingPage.DisplayAlert("錯誤", "無法取得當前視窗。", "確定");
                    }
                };

                cancelButton.Clicked += (_, _) =>
                {
                    var currentApp = Application.Current;
                    currentApp?.Quit();
                };

                return loadingPage;
            }
        }

        private static void LoadSettingsAsync(Window window, ContentPage loadingPage)
        {
            string oldVersion = "";

            // 1. 立刻載入本地設定 (存在就立刻使用)
            if (File.Exists(LocalSettingPath))
            {
                try
                {
                    var jsonText = File.ReadAllText(LocalSettingPath);
                    var jsonDoc = JsonDocument.Parse(jsonText);
                    var server = jsonDoc.RootElement.GetProperty("server").GetString() ?? "";
                    Preferences.Set("server", server);

                    // ➡️ 同時取得舊版本號
                    oldVersion = jsonDoc.RootElement.GetProperty("latestApkVersion").GetString() ?? "";                    
                }
                catch (Exception ex)
                {
                    Debug.Print($"本地設定解析錯誤: {ex.Message}");
                }
                finally
                {
                    MainThread.BeginInvokeOnMainThread(() =>
                    {
                        window.Page = new NavigationPage(new BlankPage());
                    });
                }
            }

            // 2. 背景下載新設定並比較版本
            Task.Run(async () =>
            {
                using var client = new HttpClient { Timeout = TimeSpan.FromSeconds(5) };
                try
                {
                    var jsonString = await client.GetStringAsync("https://fws.duckdns.org/api/appsetting.json");
                    var newJsonDoc = JsonDocument.Parse(jsonString);
                    var newVersion = newJsonDoc.RootElement.GetProperty("latestApkVersion").GetString() ?? "";

                    // ➡️ 比較版本號，有變化再寫入本地並檢查更新
                    if (!string.Equals(oldVersion, newVersion))
                    {
                        File.WriteAllText(LocalSettingPath, jsonString);

                        var server = newJsonDoc.RootElement.GetProperty("server").GetString() ?? "";
                        Preferences.Set("server", server);

                        // ➡️ 有版本變化，才檢查是否跳出更新通知
                        await ServiceSetting.CheckAppVersionAsync();
                    }
                    else
                    {
                        // 版本沒變，仍然要更新本地檔案，確保其他設定項也同步
                        File.WriteAllText(LocalSettingPath, jsonString);
                        var server = newJsonDoc.RootElement.GetProperty("server").GetString() ?? "";
                        Preferences.Set("server", server);
                    }
                }
                catch (Exception ex)
                {
                    Debug.Print($"背景下載設定檔錯誤: {ex.Message}");
                }
            });
        }

    }
}

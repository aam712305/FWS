#pragma warning disable CA1416 // 驗證平台相容性

using FWSAPP.Models; 
using FWSAPP.Services;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Text.Json;

namespace FWSAPP;


public partial class IDPage : ContentPage
{

    private static readonly string LocalSettingPath = Path.Combine(FileSystem.AppDataDirectory, "appsetting.json");
    private const int 每次載入筆數 = 500;
    private List<IDModel> 全部資料 = [];
    private int 目前載入索引 = 0;

    public ObservableCollection<IDModel> IDList { get; } = [];

    public async Task TriggerLoginAsync()
    {
        await ExecuteMenuButtonLogicAsync();
    }

    private readonly IWifiService _wifiService; // 新增這一行

    public IDPage(IWifiService wifiService)  // 改為此行
    {
        InitializeComponent();
        BindingContext = this;
        _wifiService = wifiService; // 新增這一行

        LoadFromSQLite(!File.Exists(ServiceSetting.LocalDbPath));
        StartAutoRefresh();
        Shell.SetNavBarIsVisible(this, false);
    }

    private async void LoadFromSQLite(bool forceDownload = false)
    {
        try
        {
            if (forceDownload || !File.Exists(ServiceSetting.LocalDbPath))
                await ServiceSetting.DownloadIDDatabaseAsync();

            全部資料 = await ServiceSetting.LoadMembersAsync();
            目前載入索引 = 0;

            MainThread.BeginInvokeOnMainThread(() =>
            {
                IDList.Clear();
                LoadNextBatch();
            });
            var currentUser = Preferences.Get("currentUser", "");
            var currentPermission = Preferences.Get("currentPermission", "");

            if (currentPermission != "現場" && currentPermission != "幹部")
            {
                var noteService = new NoteService();

                foreach (var item in 全部資料)
                {
                    string? personalNote = await noteService.GetSpecialNoteAsync(item.ID, currentUser);
                    item.個人備註 = personalNote ?? "";
                }
            }

        }
        catch (Exception ex)
        {
            await DisplayAlert("錯誤", $"資料庫載入失敗：{ex.Message}", "OK");
        }
    }

    private void LoadNextBatch()
    {
        var 下一批資料 = 全部資料.Skip(目前載入索引).Take(每次載入筆數);
        foreach (var item in 下一批資料)
            IDList.Add(item);

        目前載入索引 += 每次載入筆數;
    }

    private void IdView_RemainingItemsThresholdReached(object? sender, EventArgs e)
    {
        if (目前載入索引 < 全部資料.Count)
            LoadNextBatch();
    }

    private void StartAutoRefresh()
    {
        Dispatcher.StartTimer(TimeSpan.FromMinutes(5), () =>
        {
            LoadFromSQLite();
            return true;
        });
    }

    private async void OnForceRefreshClicked(object? sender, EventArgs e)
    {
        var cacheSyncService = Application.Current?.Handler?.MauiContext?.Services.GetService<CacheSyncService>();

        if (cacheSyncService != null)
            await cacheSyncService.AutoUpdateAsync();

        LoadFromSQLite(forceDownload: true);
    }

    private bool OnIDPageClicked點擊 = false;
    private async void OnIDPageClicked(object? sender, EventArgs e)
    {
        if (OnIDPageClicked點擊)
            return;

        OnIDPageClicked點擊 = true;

        var existingPage = Navigation.NavigationStack.FirstOrDefault(p => p is IDPage);
        if (existingPage != null)
        {
            await Navigation.PopToRootAsync();
        }
        else
        {
            var wifiService = Application.Current?.Handler?.MauiContext?.Services.GetService<IWifiService>();
            if (wifiService == null)
            {             
                OnIDPageClicked點擊 = false; //恢復可點擊
                return;
            }

            await Navigation.PushAsync(new IDPage(wifiService));
        }

        OnIDPageClicked點擊 = false; //恢復可點擊
    }

    private bool OnHistoryPageClicked點擊 = false;
    private async void OnHistoryPageClicked(object? sender, EventArgs e)
    {
        if (OnHistoryPageClicked點擊)
            return;

        OnHistoryPageClicked點擊 = true;

        var existingPage = Navigation.NavigationStack.FirstOrDefault(p => p is IDPage);
        if (existingPage != null)
        {
            await Navigation.PopToRootAsync();
        }
        else
        {
            var wifiService = Application.Current?.Handler?.MauiContext?.Services.GetService<IWifiService>();
            if (wifiService == null)
            {              
                OnHistoryPageClicked點擊 = false; //恢復可點擊
                return;
            }

            await Navigation.PushAsync(new IDPage(wifiService));
        }

        OnHistoryPageClicked點擊 = false; //恢復可點擊
    }


    private bool OnMenuButtonClicked點擊 = false;
    private async void OnMenuButtonClicked(object sender, EventArgs e)
    {
        await ExecuteMenuButtonLogicAsync();
    }

    public async Task ExecuteMenuButtonLogicAsync()
    {
        if (OnMenuButtonClicked點擊)
            return;
        OnMenuButtonClicked點擊 = true;

        try
        {
            var currentUser = Preferences.Get("currentUser", "");
            var currentPermission = Preferences.Get("currentPermission", "");

            if (!string.IsNullOrEmpty(currentUser) && !string.IsNullOrEmpty(currentPermission))
            {
                var settingsPage = Application.Current?.Handler?.MauiContext?.Services.GetService<SettingsPage>();
                if (settingsPage is not null)
                    await Navigation.PushAsync(settingsPage);
                else
                    await DisplayAlert("錯誤", "無法開啟設定頁面", "OK");

                return;
            }

            var localSettingPath = Path.Combine(FileSystem.AppDataDirectory, "appsetting.json");

            if (!File.Exists(localSettingPath))
            {
                await DisplayAlert("錯誤", "找不到本地設定檔案", "OK");
                return;
            }

            var json = File.ReadAllText(localSettingPath);
            var jsonDoc = JsonDocument.Parse(json);
            var usersArray = jsonDoc.RootElement.GetProperty("users").EnumerateArray();

            var (username, password) = await DisplayUserPasswordPromptAsync();

            if (username == null && password == null)
                return;

            var validUser = usersArray.FirstOrDefault(user =>
            {
                var storedUsername = user.GetProperty("username").GetString() ?? "";
                var storedPassword = user.GetProperty("password").GetString() ?? "";

                bool isUsernameMatch = string.Equals(storedUsername, username, StringComparison.OrdinalIgnoreCase);

                if (isUsernameMatch && string.IsNullOrEmpty(storedPassword) && string.IsNullOrEmpty(password))
                    return true;

                if (isUsernameMatch && !string.IsNullOrEmpty(storedPassword) && storedPassword == password)
                    return true;

                return false;
            });

            if (validUser.ValueKind == JsonValueKind.Undefined)
            {
                await DisplayAlert("錯誤", "帳號或密碼錯誤，無法進入設定。", "OK");
                return;
            }

            var wifiService = Application.Current?.Handler?.MauiContext?.Services.GetService<IWifiService>();
            if (wifiService == null)
            {
                await DisplayAlert("錯誤", "WifiService 未注入，無法驗證WiFi。", "OK");
                return;
            }

            var wifiName = wifiService.GetCurrentWifiName();
            var storeArray = jsonDoc.RootElement.GetProperty("store").EnumerateArray();

            var storeOfUser = validUser.GetProperty("store").GetString() ?? "";

            var storeMatchedWifiElement = storeArray
                .FirstOrDefault(store => store.GetProperty("Name").GetString() == storeOfUser);

            if (storeMatchedWifiElement.ValueKind != JsonValueKind.Undefined)
            {
                var requiredWifiName = storeMatchedWifiElement.GetProperty("wifi").GetString() ?? "";

                if (!string.IsNullOrEmpty(requiredWifiName) && wifiName != requiredWifiName)
                {                    
                    return;
                }
            }

            var permission = validUser.GetProperty("permission")[0].GetString() ?? "";

            Preferences.Set("currentUser", username);
            Preferences.Set("currentPermission", permission);

            var settingsPageFinal = Application.Current?.Handler?.MauiContext?.Services.GetService<SettingsPage>();
            if (settingsPageFinal is not null)
                await Navigation.PushAsync(settingsPageFinal);
        }
        catch (Exception ex)
        {
            await DisplayAlert("錯誤", $"無法讀取設定檔案：{ex.Message}", "OK");
        }
        finally
        {
            OnMenuButtonClicked點擊 = false;
        }
    }

    // 新增輸入帳號密碼提示的方法
    private static Task<(string? username, string? password)> DisplayUserPasswordPromptAsync()
    {
        var tcs = new TaskCompletionSource<(string?, string?)>();

        var usernameEntry = new Entry { Placeholder = "輸入帳號" };
        var passwordEntry = new Entry { IsPassword = true, Placeholder = "輸入密碼" };
        var confirmButton = new Button { Text = "確認" };
        var cancelButton = new Button { Text = "取消" };

        var popupContent = new Frame
        {
            BackgroundColor = Colors.White,
            CornerRadius = 10,
            Padding = 20,
            VerticalOptions = LayoutOptions.Center,
            HorizontalOptions = LayoutOptions.Center,
            Content = new StackLayout
            {
                Spacing = 10,
                Children =
            {
                new Label { Text = "請輸入帳號密碼", FontSize = 18, HorizontalOptions = LayoutOptions.Center },
                usernameEntry,
                passwordEntry,
                new StackLayout
                {
                    Orientation = StackOrientation.Horizontal,
                    HorizontalOptions = LayoutOptions.Center,
                    Spacing = 10,
                    Children = { confirmButton, cancelButton }
                }
            }
            }
        };

        var popupPage = new ContentPage
        {
            BackgroundColor = Color.FromArgb("#80000000"),
            Content = popupContent
        };

        confirmButton.Clicked += async (_, _) =>
        {
            if (Application.Current?.MainPage != null)
                await Application.Current.MainPage.Navigation.PopModalAsync();
            tcs.SetResult((usernameEntry.Text, passwordEntry.Text));
        };

        cancelButton.Clicked += async (_, _) =>
        {
            if (Application.Current?.MainPage != null)
                await Application.Current.MainPage.Navigation.PopModalAsync();
            tcs.SetResult((null, null));
        };

        Application.Current?.MainPage?.Navigation.PushModalAsync(popupPage);

        return tcs.Task;
    }

    private async void OnItemTapped(object sender, EventArgs e)
    {
        var tappedGrid = (Grid)sender;
        if (tappedGrid == null) return;

        var selectedItem = (IDModel)tappedGrid.BindingContext;
        if (selectedItem == null) return;

        var apiService = new NoteService();
        string username = Preferences.Get("currentUser", "");
        string permission = Preferences.Get("currentPermission", "");
        string specialNote = selectedItem.備註 ?? "";

        var imageView = new Image
        {
            Source = selectedItem.圖像,
            HeightRequest = 300,
            HorizontalOptions = LayoutOptions.Center
        };
        var gameStatusPicker = new Picker
        {
            Title = "遊戲狀況",
            ItemsSource = new List<string> { "正常", "禁打" },
            SelectedItem = selectedItem.狀態 == "True" ? "禁打" : "正常",
            HorizontalOptions = LayoutOptions.Fill,
            Margin = new Thickness(10, 0)
        };
        var tapGesture = new TapGestureRecognizer();
        tapGesture.Tapped += async (_, _) =>
        {
            var fullImage = new Image
            {
                Source = selectedItem.圖像,
                Aspect = Aspect.AspectFit,
                HorizontalOptions = LayoutOptions.Fill,
                VerticalOptions = LayoutOptions.Fill
            };
            var fullImagePage = new ContentPage
            {
                Content = new Grid { Children = { fullImage } },
                BackgroundColor = Colors.Black
            };
            await Navigation.PushAsync(fullImagePage);
        };
        imageView.GestureRecognizers.Add(tapGesture);
        
        var noteLabel = new Label
        {
            Text = specialNote,            
            Padding = new Thickness(10)
        };

        var contentStack = new VerticalStackLayout
        {
            Spacing = 10,
            Children =
        {
            imageView,            
            new HorizontalStackLayout
            {
                Spacing = 5,
                Padding = new Thickness(10, 0),
                Children =
                {
                    new Label
                    {
                        Text = "遊戲狀況：",                       
                        VerticalOptions = LayoutOptions.Center
                    },
                    gameStatusPicker
                }
            },

            new Label
            {
                Text = "現場備註",
                FontAttributes = FontAttributes.Bold,
                HorizontalOptions = LayoutOptions.Start,
                Padding = new Thickness(10, 5, 10, 0)
            },
            noteLabel,
            new Label
            {
                Text = $"修改者：{selectedItem.備註修改者}",
                Padding = new Thickness(10, 0)
            },
            new Label
            {
                Text = $"最後修改時間：{selectedItem.備註修改時間}",
                Padding = new Thickness(10, 0)
            }
        }
        };

        // 幹部與其他可修改現場備註
        if (permission != "現場")
        {
            var editButton = new Button { Text = "修改現場備註" };
            editButton.Clicked += async (_, _) =>
            {
                var editor = new Editor
                {
                    Text = specialNote,
                    AutoSize = EditorAutoSizeOption.TextChanges,
                    HeightRequest = 600
                };

                var confirmButton = new Button { Text = "確認", HorizontalOptions = LayoutOptions.Fill };
                var cancelButton = new Button { Text = "取消", HorizontalOptions = LayoutOptions.Fill };

                var buttonGrid = new Grid
                {
                    ColumnDefinitions =
                {
                    new ColumnDefinition(GridLength.Star),
                    new ColumnDefinition(GridLength.Star)
                },
                    ColumnSpacing = 10,
                    Padding = new Thickness(0, 10)
                };
                buttonGrid.Add(confirmButton, 0);
                buttonGrid.Add(cancelButton, 1);

                var stack = new VerticalStackLayout
                {
                    Padding = new Thickness(20),
                    Spacing = 10,
                    Children = { editor, buttonGrid }
                };

                var inputPage = new ContentPage
                {
                    Title = "修改備註",
                    Content = stack
                };

                confirmButton.Clicked += async (s, e) =>
                {
                    var result = editor.Text;
                    await Navigation.PopModalAsync();
                    if (!string.IsNullOrWhiteSpace(result))
                    {
                        bool noteSuccess = await apiService.UpdateCommonNoteAsync(selectedItem.ID, result, username);

                        // 新增：呼叫更新遊戲狀況的 API
                        bool gameStatusSuccess = await apiService.UpdateGameStatusAsync(
                            selectedItem.ID,
                            gameStatusPicker.SelectedItem?.ToString() == "禁打" ? "True" : "False"
                        );

                        // 更新畫面資料
                        if (noteSuccess)
                        {
                            noteLabel.Text = result;
                            selectedItem.備註 = result;
                        }

                        if (gameStatusSuccess)
                        {
                            selectedItem.狀態 = gameStatusPicker.SelectedItem?.ToString() == "禁打" ? "True" : "False";
                        }
                    }
                };

                cancelButton.Clicked += async (s, e) => await Navigation.PopModalAsync();
                await Navigation.PushModalAsync(inputPage);
            };

            contentStack.Children.Add(editButton);
        }

        // 只有「非現場、非幹部」才能看到個人備註
        if (permission != "現場" && permission != "幹部")
        {
            contentStack.Children.Add(new Label
            {
                Text = "個人備註",
                FontAttributes = FontAttributes.Bold,
                HorizontalOptions = LayoutOptions.Start,
                Padding = new Thickness(10, 5, 10, 0)
            });

            var specialNoteLabel = new Label
            {
                Text = "",               
                Padding = new Thickness(10)
            };
            contentStack.Children.Add(specialNoteLabel);

            // 非同步取得個人備註
            _ = Task.Run(async () =>
            {
                string? specialNote = await apiService.GetSpecialNoteAsync(selectedItem.ID, username);
                MainThread.BeginInvokeOnMainThread(() =>
                {
                    specialNoteLabel.Text = string.IsNullOrWhiteSpace(specialNote) ? "" : specialNote;
                });
            });

            var editPersonalNoteButton = new Button { Text = "修改備註" };
            editPersonalNoteButton.Clicked += async (_, _) =>
            {
                var editor = new Editor
                {
                    Text = specialNoteLabel.Text,
                    AutoSize = EditorAutoSizeOption.TextChanges,
                    HeightRequest = 600
                };

                var confirmButton = new Button { Text = "確認", HorizontalOptions = LayoutOptions.Fill };
                var cancelButton = new Button { Text = "取消", HorizontalOptions = LayoutOptions.Fill };

                var buttonGrid = new Grid
                {
                    ColumnDefinitions =
        {
            new ColumnDefinition(GridLength.Star),
            new ColumnDefinition(GridLength.Star)
        },
                    ColumnSpacing = 10,
                    Padding = new Thickness(0, 10)
                };
                buttonGrid.Add(confirmButton, 0);
                buttonGrid.Add(cancelButton, 1);

                var stack = new VerticalStackLayout
                {
                    Padding = new Thickness(20),
                    Spacing = 10,
                    Children = { editor, buttonGrid }
                };

                var inputPage = new ContentPage
                {
                    Title = "修改個人備註",
                    Content = stack
                };

                confirmButton.Clicked += async (s, e) =>
                {
                    var result = editor.Text;
                    await Navigation.PopModalAsync();
                    if (!string.IsNullOrWhiteSpace(result))
                    {
                        bool success = await apiService.UpdateSpecialNoteAsync(selectedItem.ID, username, result);
                        if (success)
                            specialNoteLabel.Text = result;
                    }
                };

                cancelButton.Clicked += async (s, e) => await Navigation.PopModalAsync();
                await Navigation.PushModalAsync(inputPage);
            };


            contentStack.Children.Add(editPersonalNoteButton);
        }

        var detailPage = new ContentPage
        {
            Content = new ScrollView { Content = contentStack },
            Padding = 10
        };

        await Navigation.PushAsync(detailPage);
    }



    private void SearchEntry_TextChanged(object? sender, TextChangedEventArgs e)
    {
        var searchText = e.NewTextValue?.ToLower() ?? "";

        if (string.IsNullOrWhiteSpace(searchText))
        {
            idView.ItemsSource = IDList;
        }
        else
        {
            var filtered = 全部資料.Where(m =>
                m.ID.ToString().Contains(searchText) ||
                (m.姓名?.Contains(searchText) ?? false) ||
                (m.帳號?.Contains(searchText) ?? false)
            );

            idView.ItemsSource = new ObservableCollection<IDModel>(filtered);
        }
    }
}
#pragma warning restore CA1416

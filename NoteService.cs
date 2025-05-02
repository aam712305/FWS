using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;

namespace FWSAPP.Services
{
    public class NoteService
    {
        private readonly HttpClient _httpClient;

        public NoteService()
        {
            var server = Preferences.Get("server", "").TrimEnd('/');
            if (string.IsNullOrWhiteSpace(server))
                throw new InvalidOperationException("伺服器設定錯誤！");

            _httpClient = new HttpClient
            {
                BaseAddress = new Uri(server)
            };
        }

        // 一般備註更新
        public async Task<bool> UpdateCommonNoteAsync(int id, string note, string modifiedBy)
        {
            var payload = new
            {
                ID = id,
                備註 = note,
                備註修改者 = modifiedBy
            };

            var response = await _httpClient.PostAsJsonAsync("/app/notes/updateCommonNote", payload);
            return response.IsSuccessStatusCode;
        }

        // 特別備註更新
        public async Task<bool> UpdateSpecialNoteAsync(int id, string username, string note)
        {
            var payload = new
            {
                ID = id,
                使用者帳號 = username,
                備註內容 = note
            };

            var response = await _httpClient.PostAsJsonAsync("/app/notes/updateSpecialNote", payload);
            return response.IsSuccessStatusCode;
        }

        // 特別備註查詢
        public async Task<string?> GetSpecialNoteAsync(int id, string username)
        {
            var response = await _httpClient.GetAsync($"/app/notes/getSpecialNote?ID={id}&使用者帳號={username}");

            if (response.IsSuccessStatusCode)
            {
                var result = await response.Content.ReadFromJsonAsync<SpecialNoteResponse>();
                return result?.備註內容;
            }
            return null;
        }

        private class SpecialNoteResponse
        {
            public string? 備註內容 { get; set; }
        }
    }
}

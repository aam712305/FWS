using SQLite;

namespace FWSAPP.Models
{
    [Table("ID")]  // ← 清楚指定資料庫內實際表名
    public class IDModel
    {
        [PrimaryKey]
        public int ID { get; set; }
        public string? 帳號 { get; set; }
        public string? 姓名 { get; set; }
        public string? 狀態 { get; set; }
        public string? 末四碼 { get; set; }
        public string? 等級 { get; set; }

        public string? 備註 { get; set; }
        public string? 備註修改者 { get; set; }
        public string? 備註修改時間 { get; set; }

        [Ignore]  // ← 不在SQLite內建立此欄位
        public string 圖像 => $"{Preferences.Get("server", "")}/idphoto/{ID}.jpg";
    }
}

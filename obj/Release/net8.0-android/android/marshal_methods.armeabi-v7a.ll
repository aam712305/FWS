; ModuleID = 'marshal_methods.armeabi-v7a.ll'
source_filename = "marshal_methods.armeabi-v7a.ll"
target datalayout = "e-m:e-p:32:32-Fi8-i64:64-v128:64:128-a:0:32-n32-S64"
target triple = "armv7-unknown-linux-android21"

%struct.MarshalMethodName = type {
	i64, ; uint64_t id
	ptr ; char* name
}

%struct.MarshalMethodsManagedClass = type {
	i32, ; uint32_t token
	ptr ; MonoClass klass
}

@assembly_image_cache = dso_local local_unnamed_addr global [208 x ptr] zeroinitializer, align 4

; Each entry maps hash of an assembly name to an index into the `assembly_image_cache` array
@assembly_image_cache_hashes = dso_local local_unnamed_addr constant [416 x i32] [
	i32 2616222, ; 0: System.Net.NetworkInformation.dll => 0x27eb9e => 153
	i32 10166715, ; 1: System.Net.NameResolution.dll => 0x9b21bb => 152
	i32 42639949, ; 2: System.Threading.Thread => 0x28aa24d => 194
	i32 57725457, ; 3: it\Microsoft.Data.SqlClient.resources => 0x370d211 => 4
	i32 57727992, ; 4: ja\Microsoft.Data.SqlClient.resources => 0x370dbf8 => 5
	i32 66541672, ; 5: System.Diagnostics.StackTrace => 0x3f75868 => 135
	i32 67008169, ; 6: zh-Hant\Microsoft.Maui.Controls.resources => 0x3fe76a9 => 46
	i32 68219467, ; 7: System.Security.Cryptography.Primitives => 0x410f24b => 183
	i32 72070932, ; 8: Microsoft.Maui.Graphics.dll => 0x44bb714 => 76
	i32 117431740, ; 9: System.Runtime.InteropServices => 0x6ffddbc => 171
	i32 122350210, ; 10: System.Threading.Channels.dll => 0x74aea82 => 192
	i32 139659294, ; 11: ja/Microsoft.Data.SqlClient.resources.dll => 0x853081e => 5
	i32 142721839, ; 12: System.Net.WebHeaderCollection => 0x881c32f => 160
	i32 149972175, ; 13: System.Security.Cryptography.Primitives.dll => 0x8f064cf => 183
	i32 165246403, ; 14: Xamarin.AndroidX.Collection.dll => 0x9d975c3 => 95
	i32 166535111, ; 15: ru/Microsoft.Data.SqlClient.resources.dll => 0x9ed1fc7 => 9
	i32 182336117, ; 16: Xamarin.AndroidX.SwipeRefreshLayout.dll => 0xade3a75 => 113
	i32 195452805, ; 17: vi/Microsoft.Maui.Controls.resources.dll => 0xba65f85 => 43
	i32 199333315, ; 18: zh-HK/Microsoft.Maui.Controls.resources.dll => 0xbe195c3 => 44
	i32 205061960, ; 19: System.ComponentModel => 0xc38ff48 => 130
	i32 209399409, ; 20: Xamarin.AndroidX.Browser.dll => 0xc7b2e71 => 93
	i32 230752869, ; 21: Microsoft.CSharp.dll => 0xdc10265 => 120
	i32 246610117, ; 22: System.Reflection.Emit.Lightweight => 0xeb2f8c5 => 168
	i32 264223668, ; 23: zh-Hans\Microsoft.Data.SqlClient.resources => 0xfbfbbb4 => 11
	i32 280992041, ; 24: cs/Microsoft.Maui.Controls.resources.dll => 0x10bf9929 => 15
	i32 317674968, ; 25: vi\Microsoft.Maui.Controls.resources => 0x12ef55d8 => 43
	i32 318968648, ; 26: Xamarin.AndroidX.Activity.dll => 0x13031348 => 90
	i32 330147069, ; 27: Microsoft.SqlServer.Server => 0x13ada4fd => 77
	i32 336156722, ; 28: ja/Microsoft.Maui.Controls.resources.dll => 0x14095832 => 28
	i32 342366114, ; 29: Xamarin.AndroidX.Lifecycle.Common => 0x146817a2 => 102
	i32 347068432, ; 30: SQLitePCLRaw.lib.e_sqlite3.android.dll => 0x14afd810 => 81
	i32 356389973, ; 31: it/Microsoft.Maui.Controls.resources.dll => 0x153e1455 => 27
	i32 360671332, ; 32: pl\Microsoft.Data.SqlClient.resources => 0x157f6864 => 7
	i32 367780167, ; 33: System.IO.Pipes => 0x15ebe147 => 146
	i32 374914964, ; 34: System.Transactions.Local => 0x1658bf94 => 197
	i32 375677976, ; 35: System.Net.ServicePoint.dll => 0x16646418 => 157
	i32 379916513, ; 36: System.Threading.Thread.dll => 0x16a510e1 => 194
	i32 385762202, ; 37: System.Memory.dll => 0x16fe439a => 149
	i32 392610295, ; 38: System.Threading.ThreadPool.dll => 0x1766c1f7 => 195
	i32 395744057, ; 39: _Microsoft.Android.Resource.Designer => 0x17969339 => 47
	i32 407321033, ; 40: tr/Microsoft.Data.SqlClient.resources.dll => 0x184739c9 => 10
	i32 435591531, ; 41: sv/Microsoft.Maui.Controls.resources.dll => 0x19f6996b => 39
	i32 442565967, ; 42: System.Collections => 0x1a61054f => 127
	i32 450948140, ; 43: Xamarin.AndroidX.Fragment.dll => 0x1ae0ec2c => 101
	i32 451504562, ; 44: System.Security.Cryptography.X509Certificates => 0x1ae969b2 => 184
	i32 459347974, ; 45: System.Runtime.Serialization.Primitives.dll => 0x1b611806 => 176
	i32 469710990, ; 46: System.dll => 0x1bff388e => 202
	i32 485463106, ; 47: Microsoft.IdentityModel.Abstractions => 0x1cef9442 => 66
	i32 498788369, ; 48: System.ObjectModel => 0x1dbae811 => 162
	i32 500358224, ; 49: id/Microsoft.Maui.Controls.resources.dll => 0x1dd2dc50 => 26
	i32 503918385, ; 50: fi/Microsoft.Maui.Controls.resources.dll => 0x1e092f31 => 20
	i32 513247710, ; 51: Microsoft.Extensions.Primitives.dll => 0x1e9789de => 63
	i32 539058512, ; 52: Microsoft.Extensions.Logging => 0x20216150 => 59
	i32 546455878, ; 53: System.Runtime.Serialization.Xml => 0x20924146 => 177
	i32 548916678, ; 54: Microsoft.Bcl.AsyncInterfaces => 0x20b7cdc6 => 51
	i32 592146354, ; 55: pt-BR/Microsoft.Maui.Controls.resources.dll => 0x234b6fb2 => 34
	i32 613668793, ; 56: System.Security.Cryptography.Algorithms => 0x2493d7b9 => 181
	i32 627609679, ; 57: Xamarin.AndroidX.CustomView => 0x2568904f => 99
	i32 627931235, ; 58: nl\Microsoft.Maui.Controls.resources => 0x256d7863 => 32
	i32 662205335, ; 59: System.Text.Encodings.Web.dll => 0x27787397 => 189
	i32 672442732, ; 60: System.Collections.Concurrent => 0x2814a96c => 123
	i32 683518922, ; 61: System.Net.Security => 0x28bdabca => 156
	i32 688181140, ; 62: ca/Microsoft.Maui.Controls.resources.dll => 0x2904cf94 => 14
	i32 690569205, ; 63: System.Xml.Linq.dll => 0x29293ff5 => 198
	i32 706645707, ; 64: ko/Microsoft.Maui.Controls.resources.dll => 0x2a1e8ecb => 29
	i32 709152836, ; 65: System.Security.Cryptography.Pkcs.dll => 0x2a44d044 => 88
	i32 709557578, ; 66: de/Microsoft.Maui.Controls.resources.dll => 0x2a4afd4a => 17
	i32 722857257, ; 67: System.Runtime.Loader.dll => 0x2b15ed29 => 172
	i32 723796036, ; 68: System.ClientModel.dll => 0x2b244044 => 83
	i32 748832960, ; 69: SQLitePCLRaw.batteries_v2 => 0x2ca248c0 => 79
	i32 759454413, ; 70: System.Net.Requests => 0x2d445acd => 155
	i32 762598435, ; 71: System.IO.Pipes.dll => 0x2d745423 => 146
	i32 775507847, ; 72: System.IO.Compression => 0x2e394f87 => 143
	i32 777317022, ; 73: sk\Microsoft.Maui.Controls.resources => 0x2e54ea9e => 38
	i32 789151979, ; 74: Microsoft.Extensions.Options => 0x2f0980eb => 62
	i32 804715423, ; 75: System.Data.Common => 0x2ff6fb9f => 132
	i32 823281589, ; 76: System.Private.Uri.dll => 0x311247b5 => 164
	i32 830298997, ; 77: System.IO.Compression.Brotli => 0x317d5b75 => 142
	i32 878954865, ; 78: System.Net.Http.Json => 0x3463c971 => 150
	i32 904024072, ; 79: System.ComponentModel.Primitives.dll => 0x35e25008 => 128
	i32 926902833, ; 80: tr/Microsoft.Maui.Controls.resources.dll => 0x373f6a31 => 41
	i32 967690846, ; 81: Xamarin.AndroidX.Lifecycle.Common.dll => 0x39adca5e => 102
	i32 975236339, ; 82: System.Diagnostics.Tracing => 0x3a20ecf3 => 138
	i32 975874589, ; 83: System.Xml.XDocument => 0x3a2aaa1d => 200
	i32 986514023, ; 84: System.Private.DataContractSerialization.dll => 0x3acd0267 => 163
	i32 992768348, ; 85: System.Collections.dll => 0x3b2c715c => 127
	i32 1012816738, ; 86: Xamarin.AndroidX.SavedState.dll => 0x3c5e5b62 => 112
	i32 1019214401, ; 87: System.Drawing => 0x3cbffa41 => 140
	i32 1028951442, ; 88: Microsoft.Extensions.DependencyInjection.Abstractions => 0x3d548d92 => 58
	i32 1029334545, ; 89: da/Microsoft.Maui.Controls.resources.dll => 0x3d5a6611 => 16
	i32 1035644815, ; 90: Xamarin.AndroidX.AppCompat => 0x3dbaaf8f => 91
	i32 1036536393, ; 91: System.Drawing.Primitives.dll => 0x3dc84a49 => 139
	i32 1044663988, ; 92: System.Linq.Expressions.dll => 0x3e444eb4 => 147
	i32 1048439329, ; 93: de/Microsoft.Data.SqlClient.resources.dll => 0x3e7dea21 => 1
	i32 1052210849, ; 94: Xamarin.AndroidX.Lifecycle.ViewModel.dll => 0x3eb776a1 => 104
	i32 1062017875, ; 95: Microsoft.Identity.Client.Extensions.Msal => 0x3f4d1b53 => 65
	i32 1082857460, ; 96: System.ComponentModel.TypeConverter => 0x408b17f4 => 129
	i32 1084122840, ; 97: Xamarin.Kotlin.StdLib => 0x409e66d8 => 117
	i32 1089913930, ; 98: System.Diagnostics.EventLog.dll => 0x40f6c44a => 85
	i32 1098259244, ; 99: System => 0x41761b2c => 202
	i32 1118262833, ; 100: ko\Microsoft.Maui.Controls.resources => 0x42a75631 => 29
	i32 1127624469, ; 101: Microsoft.Extensions.Logging.Debug => 0x43362f15 => 61
	i32 1138436374, ; 102: Microsoft.Data.SqlClient.dll => 0x43db2916 => 52
	i32 1168523401, ; 103: pt\Microsoft.Maui.Controls.resources => 0x45a64089 => 35
	i32 1178241025, ; 104: Xamarin.AndroidX.Navigation.Runtime.dll => 0x463a8801 => 109
	i32 1203215381, ; 105: pl/Microsoft.Maui.Controls.resources.dll => 0x47b79c15 => 33
	i32 1204575371, ; 106: Microsoft.Extensions.Caching.Memory.dll => 0x47cc5c8b => 54
	i32 1208641965, ; 107: System.Diagnostics.Process => 0x480a69ad => 134
	i32 1234928153, ; 108: nb/Microsoft.Maui.Controls.resources.dll => 0x499b8219 => 31
	i32 1260983243, ; 109: cs\Microsoft.Maui.Controls.resources => 0x4b2913cb => 15
	i32 1292207520, ; 110: SQLitePCLRaw.core.dll => 0x4d0585a0 => 80
	i32 1293217323, ; 111: Xamarin.AndroidX.DrawerLayout.dll => 0x4d14ee2b => 100
	i32 1309188875, ; 112: System.Private.DataContractSerialization => 0x4e08a30b => 163
	i32 1315359775, ; 113: cs/Microsoft.Data.SqlClient.resources.dll => 0x4e66cc1f => 0
	i32 1324164729, ; 114: System.Linq => 0x4eed2679 => 148
	i32 1335329327, ; 115: System.Runtime.Serialization.Json.dll => 0x4f97822f => 175
	i32 1373134921, ; 116: zh-Hans\Microsoft.Maui.Controls.resources => 0x51d86049 => 45
	i32 1376866003, ; 117: Xamarin.AndroidX.SavedState => 0x52114ed3 => 112
	i32 1406073936, ; 118: Xamarin.AndroidX.CoordinatorLayout => 0x53cefc50 => 96
	i32 1408764838, ; 119: System.Runtime.Serialization.Formatters.dll => 0x53f80ba6 => 174
	i32 1430672901, ; 120: ar\Microsoft.Maui.Controls.resources => 0x55465605 => 13
	i32 1452070440, ; 121: System.Formats.Asn1.dll => 0x568cd628 => 141
	i32 1458022317, ; 122: System.Net.Security.dll => 0x56e7a7ad => 156
	i32 1460893475, ; 123: System.IdentityModel.Tokens.Jwt => 0x57137723 => 86
	i32 1461004990, ; 124: es\Microsoft.Maui.Controls.resources => 0x57152abe => 19
	i32 1461234159, ; 125: System.Collections.Immutable.dll => 0x5718a9ef => 124
	i32 1462112819, ; 126: System.IO.Compression.dll => 0x57261233 => 143
	i32 1469204771, ; 127: Xamarin.AndroidX.AppCompat.AppCompatResources => 0x57924923 => 92
	i32 1470490898, ; 128: Microsoft.Extensions.Primitives => 0x57a5e912 => 63
	i32 1479771757, ; 129: System.Collections.Immutable => 0x5833866d => 124
	i32 1480492111, ; 130: System.IO.Compression.Brotli.dll => 0x583e844f => 142
	i32 1487239319, ; 131: Microsoft.Win32.Primitives => 0x58a57897 => 121
	i32 1493001747, ; 132: hi/Microsoft.Maui.Controls.resources.dll => 0x58fd6613 => 23
	i32 1498168481, ; 133: Microsoft.IdentityModel.JsonWebTokens.dll => 0x594c3ca1 => 67
	i32 1514721132, ; 134: el/Microsoft.Maui.Controls.resources.dll => 0x5a48cf6c => 18
	i32 1536373174, ; 135: System.Diagnostics.TextWriterTraceListener => 0x5b9331b6 => 136
	i32 1543031311, ; 136: System.Text.RegularExpressions.dll => 0x5bf8ca0f => 191
	i32 1551623176, ; 137: sk/Microsoft.Maui.Controls.resources.dll => 0x5c7be408 => 38
	i32 1573704789, ; 138: System.Runtime.Serialization.Json => 0x5dccd455 => 175
	i32 1582305585, ; 139: Azure.Identity => 0x5e501131 => 49
	i32 1596263029, ; 140: zh-Hant\Microsoft.Data.SqlClient.resources => 0x5f250a75 => 12
	i32 1604827217, ; 141: System.Net.WebClient => 0x5fa7b851 => 159
	i32 1622152042, ; 142: Xamarin.AndroidX.Loader.dll => 0x60b0136a => 106
	i32 1624863272, ; 143: Xamarin.AndroidX.ViewPager2 => 0x60d97228 => 115
	i32 1628113371, ; 144: Microsoft.IdentityModel.Protocols.OpenIdConnect => 0x610b09db => 70
	i32 1636350590, ; 145: Xamarin.AndroidX.CursorAdapter => 0x6188ba7e => 98
	i32 1639515021, ; 146: System.Net.Http.dll => 0x61b9038d => 151
	i32 1639986890, ; 147: System.Text.RegularExpressions => 0x61c036ca => 191
	i32 1657153582, ; 148: System.Runtime => 0x62c6282e => 178
	i32 1658251792, ; 149: Xamarin.Google.Android.Material.dll => 0x62d6ea10 => 116
	i32 1677501392, ; 150: System.Net.Primitives.dll => 0x63fca3d0 => 154
	i32 1679769178, ; 151: System.Security.Cryptography => 0x641f3e5a => 185
	i32 1711441057, ; 152: SQLitePCLRaw.lib.e_sqlite3.android => 0x660284a1 => 81
	i32 1729485958, ; 153: Xamarin.AndroidX.CardView.dll => 0x6715dc86 => 94
	i32 1736233607, ; 154: ro/Microsoft.Maui.Controls.resources.dll => 0x677cd287 => 36
	i32 1743415430, ; 155: ca\Microsoft.Maui.Controls.resources => 0x67ea6886 => 14
	i32 1744735666, ; 156: System.Transactions.Local.dll => 0x67fe8db2 => 197
	i32 1750313021, ; 157: Microsoft.Win32.Primitives.dll => 0x6853a83d => 121
	i32 1763938596, ; 158: System.Diagnostics.TraceSource.dll => 0x69239124 => 137
	i32 1766324549, ; 159: Xamarin.AndroidX.SwipeRefreshLayout => 0x6947f945 => 113
	i32 1770582343, ; 160: Microsoft.Extensions.Logging.dll => 0x6988f147 => 59
	i32 1780572499, ; 161: Mono.Android.Runtime.dll => 0x6a216153 => 206
	i32 1782862114, ; 162: ms\Microsoft.Maui.Controls.resources => 0x6a445122 => 30
	i32 1788241197, ; 163: Xamarin.AndroidX.Fragment => 0x6a96652d => 101
	i32 1793755602, ; 164: he\Microsoft.Maui.Controls.resources => 0x6aea89d2 => 22
	i32 1794500907, ; 165: Microsoft.Identity.Client.dll => 0x6af5e92b => 64
	i32 1796167890, ; 166: Microsoft.Bcl.AsyncInterfaces.dll => 0x6b0f58d2 => 51
	i32 1808609942, ; 167: Xamarin.AndroidX.Loader => 0x6bcd3296 => 106
	i32 1813058853, ; 168: Xamarin.Kotlin.StdLib.dll => 0x6c111525 => 117
	i32 1813201214, ; 169: Xamarin.Google.Android.Material => 0x6c13413e => 116
	i32 1818569960, ; 170: Xamarin.AndroidX.Navigation.UI.dll => 0x6c652ce8 => 110
	i32 1824175904, ; 171: System.Text.Encoding.Extensions => 0x6cbab720 => 188
	i32 1824722060, ; 172: System.Runtime.Serialization.Formatters => 0x6cc30c8c => 174
	i32 1828688058, ; 173: Microsoft.Extensions.Logging.Abstractions.dll => 0x6cff90ba => 60
	i32 1842015223, ; 174: uk/Microsoft.Maui.Controls.resources.dll => 0x6dcaebf7 => 42
	i32 1853025655, ; 175: sv\Microsoft.Maui.Controls.resources => 0x6e72ed77 => 39
	i32 1858542181, ; 176: System.Linq.Expressions => 0x6ec71a65 => 147
	i32 1870277092, ; 177: System.Reflection.Primitives => 0x6f7a29e4 => 169
	i32 1871986876, ; 178: Microsoft.IdentityModel.Protocols.OpenIdConnect.dll => 0x6f9440bc => 70
	i32 1875935024, ; 179: fr\Microsoft.Maui.Controls.resources => 0x6fd07f30 => 21
	i32 1910275211, ; 180: System.Collections.NonGeneric.dll => 0x71dc7c8b => 125
	i32 1922045373, ; 181: FWSAPP => 0x729015bd => 119
	i32 1939592360, ; 182: System.Private.Xml.Linq => 0x739bd4a8 => 165
	i32 1968388702, ; 183: Microsoft.Extensions.Configuration.dll => 0x75533a5e => 55
	i32 1986222447, ; 184: Microsoft.IdentityModel.Tokens.dll => 0x7663596f => 71
	i32 2003115576, ; 185: el\Microsoft.Maui.Controls.resources => 0x77651e38 => 18
	i32 2011961780, ; 186: System.Buffers.dll => 0x77ec19b4 => 122
	i32 2019465201, ; 187: Xamarin.AndroidX.Lifecycle.ViewModel => 0x785e97f1 => 104
	i32 2025202353, ; 188: ar/Microsoft.Maui.Controls.resources.dll => 0x78b622b1 => 13
	i32 2040764568, ; 189: Microsoft.Identity.Client.Extensions.Msal.dll => 0x79a39898 => 65
	i32 2045470958, ; 190: System.Private.Xml => 0x79eb68ee => 166
	i32 2055257422, ; 191: Xamarin.AndroidX.Lifecycle.LiveData.Core.dll => 0x7a80bd4e => 103
	i32 2066184531, ; 192: de\Microsoft.Maui.Controls.resources => 0x7b277953 => 17
	i32 2070888862, ; 193: System.Diagnostics.TraceSource => 0x7b6f419e => 137
	i32 2079903147, ; 194: System.Runtime.dll => 0x7bf8cdab => 178
	i32 2090596640, ; 195: System.Numerics.Vectors => 0x7c9bf920 => 161
	i32 2103459038, ; 196: SQLitePCLRaw.provider.e_sqlite3.dll => 0x7d603cde => 82
	i32 2127167465, ; 197: System.Console => 0x7ec9ffe9 => 131
	i32 2142473426, ; 198: System.Collections.Specialized => 0x7fb38cd2 => 126
	i32 2143790110, ; 199: System.Xml.XmlSerializer.dll => 0x7fc7a41e => 201
	i32 2159891885, ; 200: Microsoft.Maui => 0x80bd55ad => 74
	i32 2169148018, ; 201: hu\Microsoft.Maui.Controls.resources => 0x814a9272 => 25
	i32 2181898931, ; 202: Microsoft.Extensions.Options.dll => 0x820d22b3 => 62
	i32 2192057212, ; 203: Microsoft.Extensions.Logging.Abstractions => 0x82a8237c => 60
	i32 2193016926, ; 204: System.ObjectModel.dll => 0x82b6c85e => 162
	i32 2201107256, ; 205: Xamarin.KotlinX.Coroutines.Core.Jvm.dll => 0x83323b38 => 118
	i32 2201231467, ; 206: System.Net.Http => 0x8334206b => 151
	i32 2207618523, ; 207: it\Microsoft.Maui.Controls.resources => 0x839595db => 27
	i32 2228745826, ; 208: pt-BR\Microsoft.Data.SqlClient.resources => 0x84d7f662 => 8
	i32 2253551641, ; 209: Microsoft.IdentityModel.Protocols => 0x86527819 => 69
	i32 2265110946, ; 210: System.Security.AccessControl.dll => 0x8702d9a2 => 179
	i32 2266799131, ; 211: Microsoft.Extensions.Configuration.Abstractions => 0x871c9c1b => 56
	i32 2270573516, ; 212: fr/Microsoft.Maui.Controls.resources.dll => 0x875633cc => 21
	i32 2279755925, ; 213: Xamarin.AndroidX.RecyclerView.dll => 0x87e25095 => 111
	i32 2295906218, ; 214: System.Net.Sockets => 0x88d8bfaa => 158
	i32 2303942373, ; 215: nb\Microsoft.Maui.Controls.resources => 0x89535ee5 => 31
	i32 2305521784, ; 216: System.Private.CoreLib.dll => 0x896b7878 => 204
	i32 2309278602, ; 217: ko\Microsoft.Data.SqlClient.resources => 0x89a4cb8a => 6
	i32 2340441535, ; 218: System.Runtime.InteropServices.RuntimeInformation.dll => 0x8b804dbf => 170
	i32 2353062107, ; 219: System.Net.Primitives => 0x8c40e0db => 154
	i32 2368005991, ; 220: System.Xml.ReaderWriter.dll => 0x8d24e767 => 199
	i32 2369706906, ; 221: Microsoft.IdentityModel.Logging => 0x8d3edb9a => 68
	i32 2371007202, ; 222: Microsoft.Extensions.Configuration => 0x8d52b2e2 => 55
	i32 2383496789, ; 223: System.Security.Principal.Windows.dll => 0x8e114655 => 186
	i32 2395872292, ; 224: id\Microsoft.Maui.Controls.resources => 0x8ece1c24 => 26
	i32 2427813419, ; 225: hi\Microsoft.Maui.Controls.resources => 0x90b57e2b => 23
	i32 2435356389, ; 226: System.Console.dll => 0x912896e5 => 131
	i32 2458678730, ; 227: System.Net.Sockets.dll => 0x928c75ca => 158
	i32 2465273461, ; 228: SQLitePCLRaw.batteries_v2.dll => 0x92f11675 => 79
	i32 2471841756, ; 229: netstandard.dll => 0x93554fdc => 203
	i32 2475788418, ; 230: Java.Interop.dll => 0x93918882 => 205
	i32 2480646305, ; 231: Microsoft.Maui.Controls => 0x93dba8a1 => 72
	i32 2484371297, ; 232: System.Net.ServicePoint => 0x94147f61 => 157
	i32 2509217888, ; 233: System.Diagnostics.EventLog => 0x958fa060 => 85
	i32 2538310050, ; 234: System.Reflection.Emit.Lightweight.dll => 0x974b89a2 => 168
	i32 2550873716, ; 235: hr\Microsoft.Maui.Controls.resources => 0x980b3e74 => 24
	i32 2562349572, ; 236: Microsoft.CSharp => 0x98ba5a04 => 120
	i32 2570120770, ; 237: System.Text.Encodings.Web => 0x9930ee42 => 189
	i32 2585220780, ; 238: System.Text.Encoding.Extensions.dll => 0x9a1756ac => 188
	i32 2589602615, ; 239: System.Threading.ThreadPool => 0x9a5a3337 => 195
	i32 2593496499, ; 240: pl\Microsoft.Maui.Controls.resources => 0x9a959db3 => 33
	i32 2605712449, ; 241: Xamarin.KotlinX.Coroutines.Core.Jvm => 0x9b500441 => 118
	i32 2616218305, ; 242: Microsoft.Extensions.Logging.Debug.dll => 0x9bf052c1 => 61
	i32 2617129537, ; 243: System.Private.Xml.dll => 0x9bfe3a41 => 166
	i32 2620871830, ; 244: Xamarin.AndroidX.CursorAdapter.dll => 0x9c375496 => 98
	i32 2626831493, ; 245: ja\Microsoft.Maui.Controls.resources => 0x9c924485 => 28
	i32 2627185994, ; 246: System.Diagnostics.TextWriterTraceListener.dll => 0x9c97ad4a => 136
	i32 2628210652, ; 247: System.Memory.Data => 0x9ca74fdc => 87
	i32 2640290731, ; 248: Microsoft.IdentityModel.Logging.dll => 0x9d5fa3ab => 68
	i32 2640706905, ; 249: Azure.Core => 0x9d65fd59 => 48
	i32 2660759594, ; 250: System.Security.Cryptography.ProtectedData.dll => 0x9e97f82a => 89
	i32 2663698177, ; 251: System.Runtime.Loader => 0x9ec4cf01 => 172
	i32 2664396074, ; 252: System.Xml.XDocument.dll => 0x9ecf752a => 200
	i32 2665622720, ; 253: System.Drawing.Primitives => 0x9ee22cc0 => 139
	i32 2676780864, ; 254: System.Data.Common.dll => 0x9f8c6f40 => 132
	i32 2677098746, ; 255: Azure.Identity.dll => 0x9f9148fa => 49
	i32 2678266992, ; 256: tr\Microsoft.Data.SqlClient.resources => 0x9fa31c70 => 10
	i32 2686887180, ; 257: System.Runtime.Serialization.Xml.dll => 0xa026a50c => 177
	i32 2717744543, ; 258: System.Security.Claims => 0xa1fd7d9f => 180
	i32 2724373263, ; 259: System.Runtime.Numerics.dll => 0xa262a30f => 173
	i32 2732626843, ; 260: Xamarin.AndroidX.Activity => 0xa2e0939b => 90
	i32 2735172069, ; 261: System.Threading.Channels => 0xa30769e5 => 192
	i32 2737747696, ; 262: Xamarin.AndroidX.AppCompat.AppCompatResources.dll => 0xa32eb6f0 => 92
	i32 2740051746, ; 263: Microsoft.Identity.Client => 0xa351df22 => 64
	i32 2752995522, ; 264: pt-BR\Microsoft.Maui.Controls.resources => 0xa41760c2 => 34
	i32 2755098380, ; 265: Microsoft.SqlServer.Server.dll => 0xa437770c => 77
	i32 2758225723, ; 266: Microsoft.Maui.Controls.Xaml => 0xa4672f3b => 73
	i32 2764765095, ; 267: Microsoft.Maui.dll => 0xa4caf7a7 => 74
	i32 2765824710, ; 268: System.Text.Encoding.CodePages.dll => 0xa4db22c6 => 187
	i32 2778768386, ; 269: Xamarin.AndroidX.ViewPager.dll => 0xa5a0a402 => 114
	i32 2785988530, ; 270: th\Microsoft.Maui.Controls.resources => 0xa60ecfb2 => 40
	i32 2801831435, ; 271: Microsoft.Maui.Graphics => 0xa7008e0b => 76
	i32 2804509662, ; 272: es/Microsoft.Data.SqlClient.resources.dll => 0xa7296bde => 2
	i32 2806116107, ; 273: es/Microsoft.Maui.Controls.resources.dll => 0xa741ef0b => 19
	i32 2810250172, ; 274: Xamarin.AndroidX.CoordinatorLayout.dll => 0xa78103bc => 96
	i32 2831556043, ; 275: nl/Microsoft.Maui.Controls.resources.dll => 0xa8c61dcb => 32
	i32 2841937114, ; 276: it/Microsoft.Data.SqlClient.resources.dll => 0xa96484da => 4
	i32 2853208004, ; 277: Xamarin.AndroidX.ViewPager => 0xaa107fc4 => 114
	i32 2861189240, ; 278: Microsoft.Maui.Essentials => 0xaa8a4878 => 75
	i32 2867946736, ; 279: System.Security.Cryptography.ProtectedData => 0xaaf164f0 => 89
	i32 2891872470, ; 280: cs\Microsoft.Data.SqlClient.resources => 0xac5e78d6 => 0
	i32 2909740682, ; 281: System.Private.CoreLib => 0xad6f1e8a => 204
	i32 2916838712, ; 282: Xamarin.AndroidX.ViewPager2.dll => 0xaddb6d38 => 115
	i32 2919462931, ; 283: System.Numerics.Vectors.dll => 0xae037813 => 161
	i32 2940926066, ; 284: System.Diagnostics.StackTrace.dll => 0xaf4af872 => 135
	i32 2944313911, ; 285: System.Configuration.ConfigurationManager.dll => 0xaf7eaa37 => 84
	i32 2957275192, ; 286: Dapper => 0xb0447038 => 50
	i32 2959614098, ; 287: System.ComponentModel.dll => 0xb0682092 => 130
	i32 2968338931, ; 288: System.Security.Principal.Windows => 0xb0ed41f3 => 186
	i32 2972252294, ; 289: System.Security.Cryptography.Algorithms.dll => 0xb128f886 => 181
	i32 2978675010, ; 290: Xamarin.AndroidX.DrawerLayout => 0xb18af942 => 100
	i32 3012788804, ; 291: System.Configuration.ConfigurationManager => 0xb3938244 => 84
	i32 3023511517, ; 292: ru\Microsoft.Data.SqlClient.resources => 0xb4371fdd => 9
	i32 3033605958, ; 293: System.Memory.Data.dll => 0xb4d12746 => 87
	i32 3038032645, ; 294: _Microsoft.Android.Resource.Designer.dll => 0xb514b305 => 47
	i32 3057625584, ; 295: Xamarin.AndroidX.Navigation.Common => 0xb63fa9f0 => 107
	i32 3059408633, ; 296: Mono.Android.Runtime => 0xb65adef9 => 206
	i32 3059793426, ; 297: System.ComponentModel.Primitives => 0xb660be12 => 128
	i32 3069363400, ; 298: Microsoft.Extensions.Caching.Abstractions.dll => 0xb6f2c4c8 => 53
	i32 3077302341, ; 299: hu/Microsoft.Maui.Controls.resources.dll => 0xb76be845 => 25
	i32 3084678329, ; 300: Microsoft.IdentityModel.Tokens => 0xb7dc74b9 => 71
	i32 3090735792, ; 301: System.Security.Cryptography.X509Certificates.dll => 0xb838e2b0 => 184
	i32 3099732863, ; 302: System.Security.Claims.dll => 0xb8c22b7f => 180
	i32 3103600923, ; 303: System.Formats.Asn1 => 0xb8fd311b => 141
	i32 3121463068, ; 304: System.IO.FileSystem.AccessControl.dll => 0xba0dbf1c => 144
	i32 3124832203, ; 305: System.Threading.Tasks.Extensions => 0xba4127cb => 193
	i32 3132293585, ; 306: System.Security.AccessControl => 0xbab301d1 => 179
	i32 3147165239, ; 307: System.Diagnostics.Tracing.dll => 0xbb95ee37 => 138
	i32 3158628304, ; 308: zh-Hant/Microsoft.Data.SqlClient.resources.dll => 0xbc44d7d0 => 12
	i32 3159123045, ; 309: System.Reflection.Primitives.dll => 0xbc4c6465 => 169
	i32 3178803400, ; 310: Xamarin.AndroidX.Navigation.Fragment.dll => 0xbd78b0c8 => 108
	i32 3195844289, ; 311: Microsoft.Extensions.Caching.Abstractions => 0xbe7cb6c1 => 53
	i32 3220365878, ; 312: System.Threading => 0xbff2e236 => 196
	i32 3258312781, ; 313: Xamarin.AndroidX.CardView => 0xc235e84d => 94
	i32 3265893370, ; 314: System.Threading.Tasks.Extensions.dll => 0xc2a993fa => 193
	i32 3268887220, ; 315: fr/Microsoft.Data.SqlClient.resources.dll => 0xc2d742b4 => 3
	i32 3276600297, ; 316: pt-BR/Microsoft.Data.SqlClient.resources.dll => 0xc34cf3e9 => 8
	i32 3286872994, ; 317: SQLite-net.dll => 0xc3e9b3a2 => 78
	i32 3290767353, ; 318: System.Security.Cryptography.Encoding => 0xc4251ff9 => 182
	i32 3305363605, ; 319: fi\Microsoft.Maui.Controls.resources => 0xc503d895 => 20
	i32 3312457198, ; 320: Microsoft.IdentityModel.JsonWebTokens => 0xc57015ee => 67
	i32 3316684772, ; 321: System.Net.Requests.dll => 0xc5b097e4 => 155
	i32 3317135071, ; 322: Xamarin.AndroidX.CustomView.dll => 0xc5b776df => 99
	i32 3343947874, ; 323: fr\Microsoft.Data.SqlClient.resources => 0xc7509862 => 3
	i32 3346324047, ; 324: Xamarin.AndroidX.Navigation.Runtime => 0xc774da4f => 109
	i32 3357674450, ; 325: ru\Microsoft.Maui.Controls.resources => 0xc8220bd2 => 37
	i32 3358260929, ; 326: System.Text.Json => 0xc82afec1 => 190
	i32 3360279109, ; 327: SQLitePCLRaw.core => 0xc849ca45 => 80
	i32 3362522851, ; 328: Xamarin.AndroidX.Core => 0xc86c06e3 => 97
	i32 3366347497, ; 329: Java.Interop => 0xc8a662e9 => 205
	i32 3374879918, ; 330: Microsoft.IdentityModel.Protocols.dll => 0xc92894ae => 69
	i32 3374999561, ; 331: Xamarin.AndroidX.RecyclerView => 0xc92a6809 => 111
	i32 3381016424, ; 332: da\Microsoft.Maui.Controls.resources => 0xc9863768 => 16
	i32 3428513518, ; 333: Microsoft.Extensions.DependencyInjection.dll => 0xcc5af6ee => 57
	i32 3430777524, ; 334: netstandard => 0xcc7d82b4 => 203
	i32 3463511458, ; 335: hr/Microsoft.Maui.Controls.resources.dll => 0xce70fda2 => 24
	i32 3471940407, ; 336: System.ComponentModel.TypeConverter.dll => 0xcef19b37 => 129
	i32 3476120550, ; 337: Mono.Android => 0xcf3163e6 => 207
	i32 3479583265, ; 338: ru/Microsoft.Maui.Controls.resources.dll => 0xcf663a21 => 37
	i32 3484440000, ; 339: ro\Microsoft.Maui.Controls.resources => 0xcfb055c0 => 36
	i32 3485117614, ; 340: System.Text.Json.dll => 0xcfbaacae => 190
	i32 3509114376, ; 341: System.Xml.Linq => 0xd128d608 => 198
	i32 3545306353, ; 342: Microsoft.Data.SqlClient => 0xd35114f1 => 52
	i32 3555084973, ; 343: de\Microsoft.Data.SqlClient.resources => 0xd3e64aad => 1
	i32 3558648585, ; 344: System.ClientModel => 0xd41cab09 => 83
	i32 3561949811, ; 345: Azure.Core.dll => 0xd44f0a73 => 48
	i32 3564312303, ; 346: Dapper.dll => 0xd47316ef => 50
	i32 3570554715, ; 347: System.IO.FileSystem.AccessControl => 0xd4d2575b => 144
	i32 3580758918, ; 348: zh-HK\Microsoft.Maui.Controls.resources => 0xd56e0b86 => 44
	i32 3608519521, ; 349: System.Linq.dll => 0xd715a361 => 148
	i32 3624195450, ; 350: System.Runtime.InteropServices.RuntimeInformation => 0xd804d57a => 170
	i32 3641597786, ; 351: Xamarin.AndroidX.Lifecycle.LiveData.Core => 0xd90e5f5a => 103
	i32 3643446276, ; 352: tr\Microsoft.Maui.Controls.resources => 0xd92a9404 => 41
	i32 3643854240, ; 353: Xamarin.AndroidX.Navigation.Fragment => 0xd930cda0 => 108
	i32 3657292374, ; 354: Microsoft.Extensions.Configuration.Abstractions.dll => 0xd9fdda56 => 56
	i32 3660523487, ; 355: System.Net.NetworkInformation => 0xda2f27df => 153
	i32 3672681054, ; 356: Mono.Android.dll => 0xdae8aa5e => 207
	i32 3682565725, ; 357: Xamarin.AndroidX.Browser => 0xdb7f7e5d => 93
	i32 3697841164, ; 358: zh-Hant/Microsoft.Maui.Controls.resources.dll => 0xdc68940c => 46
	i32 3700591436, ; 359: Microsoft.IdentityModel.Abstractions.dll => 0xdc928b4c => 66
	i32 3724971120, ; 360: Xamarin.AndroidX.Navigation.Common.dll => 0xde068c70 => 107
	i32 3732100267, ; 361: System.Net.NameResolution => 0xde7354ab => 152
	i32 3737834244, ; 362: System.Net.Http.Json.dll => 0xdecad304 => 150
	i32 3748608112, ; 363: System.Diagnostics.DiagnosticSource => 0xdf6f3870 => 133
	i32 3754567612, ; 364: SQLitePCLRaw.provider.e_sqlite3 => 0xdfca27bc => 82
	i32 3786282454, ; 365: Xamarin.AndroidX.Collection => 0xe1ae15d6 => 95
	i32 3792276235, ; 366: System.Collections.NonGeneric => 0xe2098b0b => 125
	i32 3802395368, ; 367: System.Collections.Specialized.dll => 0xe2a3f2e8 => 126
	i32 3803019198, ; 368: zh-Hans/Microsoft.Data.SqlClient.resources.dll => 0xe2ad77be => 11
	i32 3807198597, ; 369: System.Security.Cryptography.Pkcs => 0xe2ed3d85 => 88
	i32 3823082795, ; 370: System.Security.Cryptography.dll => 0xe3df9d2b => 185
	i32 3841636137, ; 371: Microsoft.Extensions.DependencyInjection.Abstractions.dll => 0xe4fab729 => 58
	i32 3848348906, ; 372: es\Microsoft.Data.SqlClient.resources => 0xe56124ea => 2
	i32 3849253459, ; 373: System.Runtime.InteropServices.dll => 0xe56ef253 => 171
	i32 3875112723, ; 374: System.Security.Cryptography.Encoding.dll => 0xe6f98713 => 182
	i32 3876362041, ; 375: SQLite-net => 0xe70c9739 => 78
	i32 3885497537, ; 376: System.Net.WebHeaderCollection.dll => 0xe797fcc1 => 160
	i32 3889960447, ; 377: zh-Hans/Microsoft.Maui.Controls.resources.dll => 0xe7dc15ff => 45
	i32 3896106733, ; 378: System.Collections.Concurrent.dll => 0xe839deed => 123
	i32 3896760992, ; 379: Xamarin.AndroidX.Core.dll => 0xe843daa0 => 97
	i32 3928044579, ; 380: System.Xml.ReaderWriter => 0xea213423 => 199
	i32 3931092270, ; 381: Xamarin.AndroidX.Navigation.UI => 0xea4fb52e => 110
	i32 3953953790, ; 382: System.Text.Encoding.CodePages => 0xebac8bfe => 187
	i32 3955647286, ; 383: Xamarin.AndroidX.AppCompat.dll => 0xebc66336 => 91
	i32 3980434154, ; 384: th/Microsoft.Maui.Controls.resources.dll => 0xed409aea => 40
	i32 3987592930, ; 385: he/Microsoft.Maui.Controls.resources.dll => 0xedadd6e2 => 22
	i32 4003436829, ; 386: System.Diagnostics.Process.dll => 0xee9f991d => 134
	i32 4025784931, ; 387: System.Memory => 0xeff49a63 => 149
	i32 4046471985, ; 388: Microsoft.Maui.Controls.Xaml.dll => 0xf1304331 => 73
	i32 4054681211, ; 389: System.Reflection.Emit.ILGeneration => 0xf1ad867b => 167
	i32 4064142224, ; 390: pl/Microsoft.Data.SqlClient.resources.dll => 0xf23de390 => 7
	i32 4068434129, ; 391: System.Private.Xml.Linq.dll => 0xf27f60d1 => 165
	i32 4073602200, ; 392: System.Threading.dll => 0xf2ce3c98 => 196
	i32 4094352644, ; 393: Microsoft.Maui.Essentials.dll => 0xf40add04 => 75
	i32 4099507663, ; 394: System.Drawing.dll => 0xf45985cf => 140
	i32 4100113165, ; 395: System.Private.Uri => 0xf462c30d => 164
	i32 4101842092, ; 396: Microsoft.Extensions.Caching.Memory => 0xf47d24ac => 54
	i32 4102112229, ; 397: pt/Microsoft.Maui.Controls.resources.dll => 0xf48143e5 => 35
	i32 4125707920, ; 398: ms/Microsoft.Maui.Controls.resources.dll => 0xf5e94e90 => 30
	i32 4126470640, ; 399: Microsoft.Extensions.DependencyInjection => 0xf5f4f1f0 => 57
	i32 4127667938, ; 400: System.IO.FileSystem.Watcher => 0xf60736e2 => 145
	i32 4147896353, ; 401: System.Reflection.Emit.ILGeneration.dll => 0xf73be021 => 167
	i32 4150914736, ; 402: uk\Microsoft.Maui.Controls.resources => 0xf769eeb0 => 42
	i32 4159265925, ; 403: System.Xml.XmlSerializer => 0xf7e95c85 => 201
	i32 4164802419, ; 404: System.IO.FileSystem.Watcher.dll => 0xf83dd773 => 145
	i32 4181436372, ; 405: System.Runtime.Serialization.Primitives => 0xf93ba7d4 => 176
	i32 4182413190, ; 406: Xamarin.AndroidX.Lifecycle.ViewModelSavedState.dll => 0xf94a8f86 => 105
	i32 4196529839, ; 407: System.Net.WebClient.dll => 0xfa21f6af => 159
	i32 4208515705, ; 408: FWSAPP.dll => 0xfad8da79 => 119
	i32 4213026141, ; 409: System.Diagnostics.DiagnosticSource.dll => 0xfb1dad5d => 133
	i32 4257443520, ; 410: ko/Microsoft.Data.SqlClient.resources.dll => 0xfdc36ec0 => 6
	i32 4260525087, ; 411: System.Buffers => 0xfdf2741f => 122
	i32 4263231520, ; 412: System.IdentityModel.Tokens.Jwt.dll => 0xfe1bc020 => 86
	i32 4271975918, ; 413: Microsoft.Maui.Controls.dll => 0xfea12dee => 72
	i32 4274976490, ; 414: System.Runtime.Numerics => 0xfecef6ea => 173
	i32 4292120959 ; 415: Xamarin.AndroidX.Lifecycle.ViewModelSavedState => 0xffd4917f => 105
], align 4

@assembly_image_cache_indices = dso_local local_unnamed_addr constant [416 x i32] [
	i32 153, ; 0
	i32 152, ; 1
	i32 194, ; 2
	i32 4, ; 3
	i32 5, ; 4
	i32 135, ; 5
	i32 46, ; 6
	i32 183, ; 7
	i32 76, ; 8
	i32 171, ; 9
	i32 192, ; 10
	i32 5, ; 11
	i32 160, ; 12
	i32 183, ; 13
	i32 95, ; 14
	i32 9, ; 15
	i32 113, ; 16
	i32 43, ; 17
	i32 44, ; 18
	i32 130, ; 19
	i32 93, ; 20
	i32 120, ; 21
	i32 168, ; 22
	i32 11, ; 23
	i32 15, ; 24
	i32 43, ; 25
	i32 90, ; 26
	i32 77, ; 27
	i32 28, ; 28
	i32 102, ; 29
	i32 81, ; 30
	i32 27, ; 31
	i32 7, ; 32
	i32 146, ; 33
	i32 197, ; 34
	i32 157, ; 35
	i32 194, ; 36
	i32 149, ; 37
	i32 195, ; 38
	i32 47, ; 39
	i32 10, ; 40
	i32 39, ; 41
	i32 127, ; 42
	i32 101, ; 43
	i32 184, ; 44
	i32 176, ; 45
	i32 202, ; 46
	i32 66, ; 47
	i32 162, ; 48
	i32 26, ; 49
	i32 20, ; 50
	i32 63, ; 51
	i32 59, ; 52
	i32 177, ; 53
	i32 51, ; 54
	i32 34, ; 55
	i32 181, ; 56
	i32 99, ; 57
	i32 32, ; 58
	i32 189, ; 59
	i32 123, ; 60
	i32 156, ; 61
	i32 14, ; 62
	i32 198, ; 63
	i32 29, ; 64
	i32 88, ; 65
	i32 17, ; 66
	i32 172, ; 67
	i32 83, ; 68
	i32 79, ; 69
	i32 155, ; 70
	i32 146, ; 71
	i32 143, ; 72
	i32 38, ; 73
	i32 62, ; 74
	i32 132, ; 75
	i32 164, ; 76
	i32 142, ; 77
	i32 150, ; 78
	i32 128, ; 79
	i32 41, ; 80
	i32 102, ; 81
	i32 138, ; 82
	i32 200, ; 83
	i32 163, ; 84
	i32 127, ; 85
	i32 112, ; 86
	i32 140, ; 87
	i32 58, ; 88
	i32 16, ; 89
	i32 91, ; 90
	i32 139, ; 91
	i32 147, ; 92
	i32 1, ; 93
	i32 104, ; 94
	i32 65, ; 95
	i32 129, ; 96
	i32 117, ; 97
	i32 85, ; 98
	i32 202, ; 99
	i32 29, ; 100
	i32 61, ; 101
	i32 52, ; 102
	i32 35, ; 103
	i32 109, ; 104
	i32 33, ; 105
	i32 54, ; 106
	i32 134, ; 107
	i32 31, ; 108
	i32 15, ; 109
	i32 80, ; 110
	i32 100, ; 111
	i32 163, ; 112
	i32 0, ; 113
	i32 148, ; 114
	i32 175, ; 115
	i32 45, ; 116
	i32 112, ; 117
	i32 96, ; 118
	i32 174, ; 119
	i32 13, ; 120
	i32 141, ; 121
	i32 156, ; 122
	i32 86, ; 123
	i32 19, ; 124
	i32 124, ; 125
	i32 143, ; 126
	i32 92, ; 127
	i32 63, ; 128
	i32 124, ; 129
	i32 142, ; 130
	i32 121, ; 131
	i32 23, ; 132
	i32 67, ; 133
	i32 18, ; 134
	i32 136, ; 135
	i32 191, ; 136
	i32 38, ; 137
	i32 175, ; 138
	i32 49, ; 139
	i32 12, ; 140
	i32 159, ; 141
	i32 106, ; 142
	i32 115, ; 143
	i32 70, ; 144
	i32 98, ; 145
	i32 151, ; 146
	i32 191, ; 147
	i32 178, ; 148
	i32 116, ; 149
	i32 154, ; 150
	i32 185, ; 151
	i32 81, ; 152
	i32 94, ; 153
	i32 36, ; 154
	i32 14, ; 155
	i32 197, ; 156
	i32 121, ; 157
	i32 137, ; 158
	i32 113, ; 159
	i32 59, ; 160
	i32 206, ; 161
	i32 30, ; 162
	i32 101, ; 163
	i32 22, ; 164
	i32 64, ; 165
	i32 51, ; 166
	i32 106, ; 167
	i32 117, ; 168
	i32 116, ; 169
	i32 110, ; 170
	i32 188, ; 171
	i32 174, ; 172
	i32 60, ; 173
	i32 42, ; 174
	i32 39, ; 175
	i32 147, ; 176
	i32 169, ; 177
	i32 70, ; 178
	i32 21, ; 179
	i32 125, ; 180
	i32 119, ; 181
	i32 165, ; 182
	i32 55, ; 183
	i32 71, ; 184
	i32 18, ; 185
	i32 122, ; 186
	i32 104, ; 187
	i32 13, ; 188
	i32 65, ; 189
	i32 166, ; 190
	i32 103, ; 191
	i32 17, ; 192
	i32 137, ; 193
	i32 178, ; 194
	i32 161, ; 195
	i32 82, ; 196
	i32 131, ; 197
	i32 126, ; 198
	i32 201, ; 199
	i32 74, ; 200
	i32 25, ; 201
	i32 62, ; 202
	i32 60, ; 203
	i32 162, ; 204
	i32 118, ; 205
	i32 151, ; 206
	i32 27, ; 207
	i32 8, ; 208
	i32 69, ; 209
	i32 179, ; 210
	i32 56, ; 211
	i32 21, ; 212
	i32 111, ; 213
	i32 158, ; 214
	i32 31, ; 215
	i32 204, ; 216
	i32 6, ; 217
	i32 170, ; 218
	i32 154, ; 219
	i32 199, ; 220
	i32 68, ; 221
	i32 55, ; 222
	i32 186, ; 223
	i32 26, ; 224
	i32 23, ; 225
	i32 131, ; 226
	i32 158, ; 227
	i32 79, ; 228
	i32 203, ; 229
	i32 205, ; 230
	i32 72, ; 231
	i32 157, ; 232
	i32 85, ; 233
	i32 168, ; 234
	i32 24, ; 235
	i32 120, ; 236
	i32 189, ; 237
	i32 188, ; 238
	i32 195, ; 239
	i32 33, ; 240
	i32 118, ; 241
	i32 61, ; 242
	i32 166, ; 243
	i32 98, ; 244
	i32 28, ; 245
	i32 136, ; 246
	i32 87, ; 247
	i32 68, ; 248
	i32 48, ; 249
	i32 89, ; 250
	i32 172, ; 251
	i32 200, ; 252
	i32 139, ; 253
	i32 132, ; 254
	i32 49, ; 255
	i32 10, ; 256
	i32 177, ; 257
	i32 180, ; 258
	i32 173, ; 259
	i32 90, ; 260
	i32 192, ; 261
	i32 92, ; 262
	i32 64, ; 263
	i32 34, ; 264
	i32 77, ; 265
	i32 73, ; 266
	i32 74, ; 267
	i32 187, ; 268
	i32 114, ; 269
	i32 40, ; 270
	i32 76, ; 271
	i32 2, ; 272
	i32 19, ; 273
	i32 96, ; 274
	i32 32, ; 275
	i32 4, ; 276
	i32 114, ; 277
	i32 75, ; 278
	i32 89, ; 279
	i32 0, ; 280
	i32 204, ; 281
	i32 115, ; 282
	i32 161, ; 283
	i32 135, ; 284
	i32 84, ; 285
	i32 50, ; 286
	i32 130, ; 287
	i32 186, ; 288
	i32 181, ; 289
	i32 100, ; 290
	i32 84, ; 291
	i32 9, ; 292
	i32 87, ; 293
	i32 47, ; 294
	i32 107, ; 295
	i32 206, ; 296
	i32 128, ; 297
	i32 53, ; 298
	i32 25, ; 299
	i32 71, ; 300
	i32 184, ; 301
	i32 180, ; 302
	i32 141, ; 303
	i32 144, ; 304
	i32 193, ; 305
	i32 179, ; 306
	i32 138, ; 307
	i32 12, ; 308
	i32 169, ; 309
	i32 108, ; 310
	i32 53, ; 311
	i32 196, ; 312
	i32 94, ; 313
	i32 193, ; 314
	i32 3, ; 315
	i32 8, ; 316
	i32 78, ; 317
	i32 182, ; 318
	i32 20, ; 319
	i32 67, ; 320
	i32 155, ; 321
	i32 99, ; 322
	i32 3, ; 323
	i32 109, ; 324
	i32 37, ; 325
	i32 190, ; 326
	i32 80, ; 327
	i32 97, ; 328
	i32 205, ; 329
	i32 69, ; 330
	i32 111, ; 331
	i32 16, ; 332
	i32 57, ; 333
	i32 203, ; 334
	i32 24, ; 335
	i32 129, ; 336
	i32 207, ; 337
	i32 37, ; 338
	i32 36, ; 339
	i32 190, ; 340
	i32 198, ; 341
	i32 52, ; 342
	i32 1, ; 343
	i32 83, ; 344
	i32 48, ; 345
	i32 50, ; 346
	i32 144, ; 347
	i32 44, ; 348
	i32 148, ; 349
	i32 170, ; 350
	i32 103, ; 351
	i32 41, ; 352
	i32 108, ; 353
	i32 56, ; 354
	i32 153, ; 355
	i32 207, ; 356
	i32 93, ; 357
	i32 46, ; 358
	i32 66, ; 359
	i32 107, ; 360
	i32 152, ; 361
	i32 150, ; 362
	i32 133, ; 363
	i32 82, ; 364
	i32 95, ; 365
	i32 125, ; 366
	i32 126, ; 367
	i32 11, ; 368
	i32 88, ; 369
	i32 185, ; 370
	i32 58, ; 371
	i32 2, ; 372
	i32 171, ; 373
	i32 182, ; 374
	i32 78, ; 375
	i32 160, ; 376
	i32 45, ; 377
	i32 123, ; 378
	i32 97, ; 379
	i32 199, ; 380
	i32 110, ; 381
	i32 187, ; 382
	i32 91, ; 383
	i32 40, ; 384
	i32 22, ; 385
	i32 134, ; 386
	i32 149, ; 387
	i32 73, ; 388
	i32 167, ; 389
	i32 7, ; 390
	i32 165, ; 391
	i32 196, ; 392
	i32 75, ; 393
	i32 140, ; 394
	i32 164, ; 395
	i32 54, ; 396
	i32 35, ; 397
	i32 30, ; 398
	i32 57, ; 399
	i32 145, ; 400
	i32 167, ; 401
	i32 42, ; 402
	i32 201, ; 403
	i32 145, ; 404
	i32 176, ; 405
	i32 105, ; 406
	i32 159, ; 407
	i32 119, ; 408
	i32 133, ; 409
	i32 6, ; 410
	i32 122, ; 411
	i32 86, ; 412
	i32 72, ; 413
	i32 173, ; 414
	i32 105 ; 415
], align 4

@marshal_methods_number_of_classes = dso_local local_unnamed_addr constant i32 0, align 4

@marshal_methods_class_cache = dso_local local_unnamed_addr global [0 x %struct.MarshalMethodsManagedClass] zeroinitializer, align 4

; Names of classes in which marshal methods reside
@mm_class_names = dso_local local_unnamed_addr constant [0 x ptr] zeroinitializer, align 4

@mm_method_names = dso_local local_unnamed_addr constant [1 x %struct.MarshalMethodName] [
	%struct.MarshalMethodName {
		i64 0, ; id 0x0; name: 
		ptr @.MarshalMethodName.0_name; char* name
	} ; 0
], align 8

; get_function_pointer (uint32_t mono_image_index, uint32_t class_index, uint32_t method_token, void*& target_ptr)
@get_function_pointer = internal dso_local unnamed_addr global ptr null, align 4

; Functions

; Function attributes: "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" uwtable willreturn
define void @xamarin_app_init(ptr nocapture noundef readnone %env, ptr noundef %fn) local_unnamed_addr #0
{
	%fnIsNull = icmp eq ptr %fn, null
	br i1 %fnIsNull, label %1, label %2

1: ; preds = %0
	%putsResult = call noundef i32 @puts(ptr @.str.0)
	call void @abort()
	unreachable 

2: ; preds = %1, %0
	store ptr %fn, ptr @get_function_pointer, align 4, !tbaa !3
	ret void
}

; Strings
@.str.0 = private unnamed_addr constant [40 x i8] c"get_function_pointer MUST be specified\0A\00", align 1

;MarshalMethodName
@.MarshalMethodName.0_name = private unnamed_addr constant [1 x i8] c"\00", align 1

; External functions

; Function attributes: "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8"
declare void @abort() local_unnamed_addr #2

; Function attributes: nofree nounwind
declare noundef i32 @puts(ptr noundef) local_unnamed_addr #1
attributes #0 = { "min-legal-vector-width"="0" mustprogress "no-trapping-math"="true" nofree norecurse nosync nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" uwtable willreturn }
attributes #1 = { nofree nounwind }
attributes #2 = { "no-trapping-math"="true" noreturn nounwind "stack-protector-buffer-size"="8" "target-cpu"="generic" "target-features"="+armv7-a,+d32,+dsp,+fp64,+neon,+vfp2,+vfp2sp,+vfp3,+vfp3d16,+vfp3d16sp,+vfp3sp,-aes,-fp-armv8,-fp-armv8d16,-fp-armv8d16sp,-fp-armv8sp,-fp16,-fp16fml,-fullfp16,-sha2,-thumb-mode,-vfp4,-vfp4d16,-vfp4d16sp,-vfp4sp" }

; Metadata
!llvm.module.flags = !{!0, !1, !7}
!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!llvm.ident = !{!2}
!2 = !{!"Xamarin.Android remotes/origin/release/8.0.4xx @ a8cd27e430e55df3e3c1e3a43d35c11d9512a2db"}
!3 = !{!4, !4, i64 0}
!4 = !{!"any pointer", !5, i64 0}
!5 = !{!"omnipotent char", !6, i64 0}
!6 = !{!"Simple C++ TBAA"}
!7 = !{i32 1, !"min_enum_size", i32 4}

using System;
using System.Globalization;
using Microsoft.Maui.Controls;

namespace FWSAPP.Converters
{
    public class MultiplyFontConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            if (value is double scale)
            {
                double baseSize = 14; // 預設基準字體大小
                return baseSize * scale;
            }
            return 14;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}

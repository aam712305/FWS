using System;
using System.Globalization;
using Microsoft.Maui.Controls;

namespace FWSAPP.Converters
{
    public class BoolToBanTextConverter : IValueConverter
    {
        public object? Convert(object? value, Type targetType, object? parameter, CultureInfo culture)
        {
            if (value is bool b && b)
                return " (禁打)";
            return "";
        }

        public object? ConvertBack(object? value, Type targetType, object? parameter, CultureInfo culture)
            => throw new NotImplementedException();
    }
}

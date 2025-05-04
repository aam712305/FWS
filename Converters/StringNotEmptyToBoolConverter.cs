using System;
using System.Globalization;
using Microsoft.Maui.Controls;

namespace FWSAPP.Converters
{
    public class StringNotEmptyToBoolConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            var text = value as string;
            return !string.IsNullOrWhiteSpace(text);
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}

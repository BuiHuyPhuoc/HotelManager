using System.Text.Json;
using System.Text.Json.Serialization;

namespace BookingHotelAPI.Class
{
    public class DateOnlyJsonConverter : JsonConverter<DateOnly>
    {
        private static readonly string[] Formats = { "yyyy-MM-dd", "dd-MM-yyyy", "dd/MM/yyyy" };

        public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var value = reader.GetString();

            if (value == null)
            {
                throw new JsonException("Invalid date format. Date string is null.");
            }

            foreach (var format in Formats)
            {
                if (DateOnly.TryParseExact(value, format, null, System.Globalization.DateTimeStyles.None, out DateOnly result))
                {
                    return result;
                }
            }

            throw new JsonException($"Invalid date format. Expected formats: {string.Join(" or ", Formats)}");
        }

        public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString(Formats[0])); // Default to first format for writing
        }
    }

}

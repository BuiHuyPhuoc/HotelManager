using System;
using System.Collections.Generic;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace BookingHotelAPI.Models;

public partial class User
{
    public int? UserId { get; set; }

    public string? UserGmail { get; set; }

    public string? UserPassword { get; set; }

    public string? UserName { get; set; }

    public DateOnly? DateOfBirth { get; set; }

    public string? UserPhone { get; set; }

    public string? UserIdcard { get; set; }

    public class DateOnlyJsonConverter : JsonConverter<DateOnly>
    {
        private const string Format = "yyyy-MM-dd";

        public override DateOnly Read(ref Utf8JsonReader reader, Type typeToConvert, JsonSerializerOptions options)
        {
            var value = reader.GetString();

            if (DateOnly.TryParseExact(value, Format, null, System.Globalization.DateTimeStyles.None, out DateOnly result))
            {
                return result;
            }
            else
            {
                throw new JsonException($"Invalid date format. Expected format: {Format}");
            }
        }

        public override void Write(Utf8JsonWriter writer, DateOnly value, JsonSerializerOptions options)
        {
            writer.WriteStringValue(value.ToString(Format));
        }
    }
}

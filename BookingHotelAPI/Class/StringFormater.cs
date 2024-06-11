using BookingHotelAPI.Models;
using Microsoft.Identity.Client;
using System.Net.Mail;
using System.Text.RegularExpressions;

namespace BookingHotelAPI.Class
{
    public class StringFormater
    {
        public static bool EmailIsValid(string emailaddress)
        {
            try
            {
                MailAddress m = new MailAddress(emailaddress);

                return true;
            }
            catch (FormatException)
            {
                return false;
            }
        }

        public static bool PhoneNumberIsValid(string phoneNumber)
        {
            return phoneNumber.Length == 10;
        }

        public static bool PasswordIsValid(string password)
        {
            var hasNumber = new Regex(@"[0-9]+");
            var hasUpperChar = new Regex(@"[A-Z]+");
            var hasMinimum8Chars = new Regex(@".{8,}");
            return hasNumber.IsMatch(password) && hasUpperChar.IsMatch(password) && hasMinimum8Chars.IsMatch(password);
        }


        public static bool IsOver18(DateOnly? date)
        {
            if (date.HasValue)
            {
                var today = DateOnly.FromDateTime(DateTime.Today);
                var age = today.Year - date.Value.Year;

                // Kiểm tra nếu ngày sinh nhật của người đó trong năm nay chưa đến
                if (date.Value.AddYears(age) > today)
                {
                    age--;
                }

                return age >= 18;
            }
            else
            {
                // Nếu DateOfBirth là null, bạn có thể quyết định trả về false hoặc ném một ngoại lệ
                // return false;
                throw new ArgumentNullException("DateOfBirth", "Date of Birth cannot be null.");
            }
        }

        public static bool IDCardIsValid(string idCard)
        {
            return idCard.Length == 12;
        }
    }
}

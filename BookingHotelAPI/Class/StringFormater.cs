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


        public static bool IsOver18(DateTime date)
        {
            // Lấy ngày hiện tại
            DateTime currentDate = DateTime.Now;

            // Tính toán số tuổi
            int age = currentDate.Year - date.Year;

            // Kiểm tra nếu ngày sinh chưa đến trong năm hiện tại, trừ đi 1 năm
            if (currentDate < date.AddYears(age))
            {
                age--;
            }

            // Trả về true nếu tuổi lớn hơn hoặc bằng 18, ngược lại trả về false
            return age >= 18;
        }


        public static bool IDCardIsValid(string idCard)
        {
            return idCard.Length == 12;
        }
    }
}

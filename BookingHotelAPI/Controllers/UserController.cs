using BookingHotelAPI.Class;
using BookingHotelAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Storage;
using Microsoft.IdentityModel.Tokens;
using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;
using System.Net.Mail;
using System.Numerics;
using System.Runtime.CompilerServices;

namespace BookingHotelAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : Controller
    {
        DbBookingHotelContext db = new DbBookingHotelContext();
        [HttpGet]
        [Route("GetAllUsers")]
        public JsonResult GetUser()
        {
            var users = db.Users.ToList();
            return Json(users);
        }
        [HttpGet]
        [Route("UserLogin")]
        public JsonResult UserLogin(string UserGmail, string UserPassword)
        {
            var getUser = db.Users.Where(x => x.UserGmail == UserGmail && x.UserPassword == UserPassword).FirstOrDefault();
            return Json(getUser);
        }

        [HttpPost]
        [Route("UserRegister")]
        public ActionResult UserRegister([FromBody] User user)
        {
            try
            {
                if (user == null)
                {
                    return BadRequest("Vui lòng nhập đủ thông tin.");
                }
                else
                {
                    if (string.IsNullOrEmpty(user.UserGmail) ||
                        string.IsNullOrEmpty(user.UserPhone) ||
                        string.IsNullOrEmpty(user.UserPassword) ||
                        string.IsNullOrEmpty(user.UserName) ||
                        string.IsNullOrEmpty(user.UserIdcard))
                        return BadRequest("Vui lòng nhập đủ thông tin.");

                    if (!StringFormater.EmailIsValid(user.UserGmail))
                        return BadRequest("Sai định dạng email.");

                    if (!StringFormater.PhoneNumberIsValid(user.UserPhone))
                        return BadRequest("Số điện thoại bao gồm 10 kí tự số.");

                    if (!StringFormater.IDCardIsValid(user.UserIdcard))
                    {
                        return BadRequest("Sai định dạng số định danh.");
                    }
                    var getUser = db.Users.Where(x => x.UserGmail == user.UserGmail).FirstOrDefault();
                    if (getUser != null)
                        return Conflict("Email đã tồn tại.");
                    try
                    {
                        if (!StringFormater.IsOver18(user.DateOfBirth))
                        {
                            return Conflict("Người dùng chưa đủ 18 tuổi.");
                        }
                    }
                    catch
                    {
                        return BadRequest("Sai định dạng ngày sinh.");
                    }


                    getUser = db.Users.Where(x => x.UserIdcard == user.UserIdcard).FirstOrDefault();
                    if (getUser != null)
                        return Conflict("Số định danh đã tồn tại.");

                    if (!StringFormater.PasswordIsValid(user.UserPassword))
                        return Conflict("Mật khẩu phải lớn hơn 8 chữ số bao gồm kí tự hoa, kí tự số và kí tự đặc biệt.");

                    db.Users.Add(user);
                    db.SaveChanges();
                    return Ok("Register account success.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
           
          
        }


        // Validation Format Email

    }
}

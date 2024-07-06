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

        public class UserLoginDto
        {
            public string UserGmail { get; set; }
            public string UserPassword { get; set; }
        }

        [HttpPost]
        [Route("UserLogin")]
        public ActionResult UserLogin([FromBody] UserLoginDto loginDto)
        {
            var getUser = db.Users
                            .Where(x => x.UserGmail == loginDto.UserGmail && x.UserPassword == loginDto.UserPassword)
                            .FirstOrDefault();

            if (getUser != null)
            {
                // Trả về thông báo thành công và thông tin người dùng
                return Ok(new { Status = true, User = getUser });
            }
            else
            {
                // Trả về thông báo thất bại
                return Ok(new { Status = false, User = (User?)null });
            }
        }

        [HttpGet]
        [Route("GetUserByEmail")]
        public IActionResult GetUserByEmail(string email)
        {
            var getUser = db.Users
                            .Where(x => x.UserGmail == email)
                            .FirstOrDefault();
            return Ok(getUser);
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
                        return BadRequest("Sai định dạng email");

                    if (!StringFormater.PhoneNumberIsValid(user.UserPhone))
                        return BadRequest("Số điện thoại bao gồm 10 kí tự số");

                    if (!StringFormater.IDCardIsValid(user.UserIdcard))
                    {
                        return BadRequest("Sai định dạng số định danh");
                    }
                    var getUser = db.Users.Where(x => x.UserGmail == user.UserGmail).FirstOrDefault();
                    if (getUser != null)
                        return Conflict("Email đã tồn tại");
                    try
                    {
                        if (user.DateOfBirth is not null)
                        {
                            if (!StringFormater.IsOver18((DateTime)user.DateOfBirth))
                            {
                                return Conflict("Người dùng chưa đủ 18 tuổi");
                            }
                        }
                    }
                    catch
                    {
                        return BadRequest("Sai định dạng ngày sinh");
                    }


                    getUser = db.Users.Where(x => x.UserIdcard == user.UserIdcard).FirstOrDefault();
                    if (getUser != null)
                        return Conflict("Số định danh đã tồn tại.");

                    if (!StringFormater.PasswordIsValid(user.UserPassword))
                        return Conflict("Mật khẩu phải lớn hơn 8 chữ số bao gồm kí tự hoa, kí tự số và kí tự đặc biệt");

                    db.Users.Add(user);
                    db.SaveChanges();
                    return Ok("Tạo tài khoản thành công.");
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

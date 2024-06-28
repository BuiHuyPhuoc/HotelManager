using BookingHotelAPI.Models;
using Microsoft.AspNetCore.Mvc;

namespace BookingHotelAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookingController : Controller
    {
        DbBookingHotelContext db = new DbBookingHotelContext();

        [HttpPost]
        [Route("CreateBookingOrder")]
        public IActionResult CreateBookingOrder([FromBody] Booking booking)
        {
            try
            {
                if (booking != null)
                {
                    if (booking.StartDate >= booking.EndDate)
                    {
                        throw new Exception("Ngày checkout trước ngày checkin.");
                    }
                    db.Bookings.Add(booking);
                    db.SaveChanges();
                    return Ok("Tạo đơn đặt thành công.");
                }
                else
                {
                    return BadRequest("Tạo đơn đặt thất bại.");
                }
            }
            catch (Exception ex)
            {
                return BadRequest("Đã có lỗi trong quá trình tạo đơn. Mã lỗi: " + ex.Message);
            }
        }

        [HttpGet]
        [Route("AllBookingOrder")]
        public IActionResult GetAllBookingOrder()
        {
            var getAllBookingOrder = db.Bookings.ToList();
            return Ok(getAllBookingOrder);
        }
    }
}

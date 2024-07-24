using BookingHotelAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;

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

        [HttpPut("{bookingId}")]
        public IActionResult UpdateBookingStatus(string bookingId, [FromBody] String status)
        {
            try
            {
                int parseValue = int.Parse(bookingId);
                var getBookingRoom = db.Bookings.Where(x => x.BookingId == parseValue).FirstOrDefault();
                if (status == "Unpaid" || status == "Paid" || status == "Cancelled")
                {
                    if (getBookingRoom == null)
                    {
                        return NotFound("Room not found");
                    }
                    else
                    {  
                        getBookingRoom.BookingStatus = status;
                        db.SaveChanges();
                        return Ok();
                    }
                }
                else
                {
                    return Conflict("Booking status is Unpaid, Paid, or Cancelled.");
                }
            }
            catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }

        [HttpGet]
        [Route("GetBookingByBookingId")]
        public IActionResult GetBookingByBookingId(string bookingId) {
            try
            {
                int parseValue = int.Parse(bookingId);
                var booking = db.Bookings.Where(x => x.BookingId == parseValue).FirstOrDefault();
                if (booking == null)
                {
                    return NotFound("Room is not found");
                } else
                {
                    return Ok(booking);
                }
            }
            catch
            {
                return BadRequest("Error");
            }
        }

        [HttpGet]
        [Route("GetBookingByUserId")]
        public IActionResult GetBookingByUserId(string userId)
        {
            try
            {
                int parseValue = int.Parse(userId);
                var booking = db.Bookings.Where(x => x.UserId == parseValue).ToList();
                return Ok(booking);
            } catch (Exception e)
            {
                return BadRequest(e.Message);
            }
        }
    }
}

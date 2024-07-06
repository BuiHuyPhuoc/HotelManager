using BookingHotelAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Immutable;
using System.Text;
using System.Text.Json;

namespace BookingHotelAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HotelController : Controller
    {
        DbBookingHotelContext db = new DbBookingHotelContext();
        Encoding asciiEncoding = Encoding.UTF8;

        [HttpGet]
        [Route("HotelByID")]
        public IActionResult HotelByID(string id)
        {
            int hotelID = int.Parse(id);
            return Ok(db.Hotels.Where(x => x.HotelId == hotelID).FirstOrDefault());
        }

        [HttpGet]
        [Route("GetCities")]
        public IActionResult GetCities()
        {
            var cities = db.Hotels.Select(x => x.HotelCity).Distinct().ToList();

            return new JsonResult(cities, new JsonSerializerOptions
            {
                Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping
            });
        }

        [HttpGet]
        [Route("GetHotels")]
        public IActionResult GetHotels() {
            var hotels = db.Hotels.ToList();
            return Ok(hotels);
        }
    }
}

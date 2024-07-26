using BookingHotelAPI.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Frozen;

namespace BookingHotelAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DeviceController : Controller
    {
        DbBookingHotelContext db = new DbBookingHotelContext();
        [HttpGet]
        [Route("GetAllDevices")]
        public IActionResult GetAllDevices()
        {
            var getAll = db.LoginDevices.ToList();
            return Ok(getAll);
        }

        [HttpGet]
        [Route("GetDeviceByUserId")]
        public IActionResult GetDeviceByUserId(string userId)
        {
            try
            {
                int parseValue = int.Parse(userId);
                var getDevices = db.LoginDevices.Where(x => x.UserId == parseValue).ToList();
                return Ok(getDevices);
            }
            catch {
                return BadRequest("Failed");
            }
        }

        [HttpPost]
        [Route("SaveDevice")]
        public IActionResult SaveDevice(LoginDevice device)
        {
            var getDevice = db.LoginDevices.Where(x => x.UserId == device.UserId && x.DeviceToken == device.DeviceToken).FirstOrDefault();
            if (getDevice == null)
            {
                db.LoginDevices.Add(device);
                db.SaveChanges();
                return Ok("Saved");
            } else
            {
                getDevice.DeviceToken = device.DeviceToken;
                db.SaveChanges();
                return Ok("Changed");
            }
        }
    }
}

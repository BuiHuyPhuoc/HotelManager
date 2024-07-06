using BookingHotelAPI.Services;
using Microsoft.AspNetCore.Mvc;

namespace BookingHotelAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class VnPayAPIController : ControllerBase
    {
        private readonly IConfiguration _configuration;
        private readonly IHttpContextAccessor _httpContextAccessor;

        public VnPayAPIController(IConfiguration configuration, IHttpContextAccessor httpContextAccessor)
        {
            _configuration = configuration;
            _httpContextAccessor = httpContextAccessor;
        }

        [HttpGet("create-payment-url")]
        public IActionResult CreatePaymentUrl()
        {
            var vnpay = new VnPayLibrary();
            vnpay.AddRequestData("vnp_Amount", "10000000"); // Example amount
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress(_httpContextAccessor));
            vnpay.AddRequestData("vnp_Locale", "vn");
            vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:123456");
            vnpay.AddRequestData("vnp_OrderType", "other");
            vnpay.AddRequestData("vnp_ReturnUrl", "http://localhost:5000/api/vnpay/return");
            vnpay.AddRequestData("vnp_TmnCode", _configuration["VnPay:TmnCode"]);
            vnpay.AddRequestData("vnp_TxnRef", DateTime.Now.Ticks.ToString());
            vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);

            string paymentUrl = vnpay.CreateRequestUrl(_configuration["VnPay:BaseUrl"], _configuration["VnPay:HashSecret"]);
            return Ok(new { paymentUrl });
        }
    }
}

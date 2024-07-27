using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class LoginDevice
{
    public int UserId { get; set; }

    public string DeviceToken { get; set; } = null!;

    public bool? LoginStatus { get; set; }

    public virtual User User { get; set; } = null!;
}

using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class Hotel
{
    public int HotelId { get; set; }

    public string? HotelName { get; set; }

    public string? HotelAddress { get; set; }

    public string? HotelCity { get; set; }

    public string? HotelPhone { get; set; }
}

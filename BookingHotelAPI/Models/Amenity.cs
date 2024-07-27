using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class Amenity
{
    public int? RoomId { get; set; }

    public string? AmenityName { get; set; }

    public virtual Room? Room { get; set; }
}

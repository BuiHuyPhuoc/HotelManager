using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class Order
{
    public int OrderId { get; set; }

    public DateTime? OrderDate { get; set; }

    public decimal? OrderPrice { get; set; }

    public int? RoomId { get; set; }

    public int? UserId { get; set; }

    public int? BookingId { get; set; }
}

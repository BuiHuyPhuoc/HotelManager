using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class Booking
{
    public int BookingId { get; set; }

    public DateTime? StartDate { get; set; }

    public DateTime? EndDate { get; set; }

    public string? BookingStatus { get; set; }

    public decimal? BookingPaid { get; set; }

    public decimal? BookingPrice { get; set; }

    public decimal? BookingDiscount { get; set; }

    public int? UserId { get; set; }

    public int? RoomId { get; set; }

    public DateTime? BookingDate { get; set; }

    public virtual Room? Room { get; set; }

    public virtual User? User { get; set; }
}

using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class Booking
{
    public int BookingId { get; set; }

    public DateOnly? StartDate { get; set; }

    public DateOnly? EndDate { get; set; }

    public string? BookingStatus { get; set; }

    public decimal? BookingPaid { get; set; }

    public decimal? BookingPrice { get; set; }
}

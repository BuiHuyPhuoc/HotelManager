using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class Room
{
    public int RoomId { get; set; }

    public string? RoomDescription { get; set; }

    public short? NumberPeople { get; set; }

    public decimal? Price { get; set; }

    public decimal? DiscountPrice { get; set; }

    public string? RoomImage { get; set; }

    public int? HotelId { get; set; }

    public bool? RoomValid { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();
}

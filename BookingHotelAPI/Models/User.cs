using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class User
{
    public int UserId { get; set; }

    public string? UserGmail { get; set; }

    public string? UserPassword { get; set; }

    public string? UserName { get; set; }

    public DateTime? DateOfBirth { get; set; }

    public string? UserPhone { get; set; }

    public string? UserIdcard { get; set; }

    public string? Role { get; set; }

    public virtual ICollection<Booking> Bookings { get; set; } = new List<Booking>();

    public virtual ICollection<Favorite> Favorites { get; set; } = new List<Favorite>();

    public virtual ICollection<LoginDevice> LoginDevices { get; set; } = new List<LoginDevice>();
}

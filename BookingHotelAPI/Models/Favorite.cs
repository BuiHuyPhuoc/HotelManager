using System;
using System.Collections.Generic;

namespace BookingHotelAPI.Models;

public partial class Favorite
{
    public int RoomId { get; set; }

    public int UserId { get; set; }

    public DateTime? Date { get; set; }

    public virtual Room Room { get; set; } = null!;

    public virtual User User { get; set; } = null!;
}

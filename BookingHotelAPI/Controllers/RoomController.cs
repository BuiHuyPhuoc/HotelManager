using Azure.Core;
using BookingHotelAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace BookingHotelAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RoomController : Controller
    {
        DbBookingHotelContext db = new DbBookingHotelContext();
        [HttpGet]
        [Route("GetRoomsDefault")]
        public IActionResult ShowRoomsDefault()
        {
        
            // Linq query tương ứng
            var query = from r in db.Rooms
                        join h in db.Hotels on r.HotelId equals h.HotelId
                        join f in db.Favorites on r.RoomId equals f.RoomId into g
                        select new
                        {
                            r.RoomId,
                            r.HotelId,
                            r.RoomDescription,
                            r.NumberPeople,
                            r.Price,
                            r.DiscountPrice,
                            r.RoomImage,
                            r.RoomValid,
                            h.HotelName,
                            h.HotelCity,
                            h.HotelAddress,
                            h.HotelPhone,
                            LikeCount = g.Count()
                        } into grouped
                        group grouped by grouped.HotelId into groupedByHotel
                        select groupedByHotel.OrderByDescending(x => x.LikeCount).FirstOrDefault();

            return Ok(query);
        }

        [HttpGet]
        [Route("MostFavoriteRooms")]
        public IActionResult ShowMostFavoriteRooms()
        {
            var _room = from room in db.Rooms
                         join h in db.Hotels
                         on room.HotelId equals h.HotelId
                         select new
                         {
                             h.HotelName,
                             h.HotelCity,
                             h.HotelAddress,
                             h.HotelPhone,
                             room.RoomId,
                             room.RoomDescription,
                             room.NumberPeople,
                             room.Price,
                             room.DiscountPrice,
                             room.RoomImage,
                             room.HotelId,
                             room.RoomValid
                         };
            var top5Rooms = db.Favorites
            .GroupBy(f => f.RoomId)
            .Select(g => new
            {
                RoomID = g.Key,
                LikeCount = g.Count()
            })
               .OrderByDescending(x => x.LikeCount)
            .Take(5)
            .Join(_room,
            f => f.RoomID,
            _room => _room.RoomId,
            (f, _room) => new
            {
                _room,
                f.LikeCount,
            });
            return Ok(top5Rooms);
        }

        [HttpGet]
        [Route("SaleRooms")]
        public IActionResult ShowBestSaleRooms()
        {
            var query = from r in db.Rooms where r.DiscountPrice < r.Price
                        join h in db.Hotels on r.HotelId equals h.HotelId
                        join f in db.Favorites on r.RoomId equals f.RoomId into g
                        select new
                        {
                            r.RoomId,
                            r.HotelId,
                            r.RoomDescription,
                            r.NumberPeople,
                            r.Price,
                            r.DiscountPrice,
                            r.RoomImage,
                            r.RoomValid,
                            h.HotelName,
                            h.HotelCity,
                            h.HotelAddress,
                            h.HotelPhone,
                            LikeCount = g.Count()
                        } into grouped
                        group grouped by grouped.HotelId into groupedByHotel
                        select groupedByHotel.OrderByDescending(x => x.LikeCount).FirstOrDefault();

            return Ok(query);
        }

        [HttpGet]
        [Route("GetRoomById")]
        public IActionResult GetRoomById(string id)
        {
            try
            {
                int parseId = int.Parse(id);
                var _room = (from room in db.Rooms where room.RoomId == parseId
                            join h in db.Hotels
                            on room.HotelId equals h.HotelId
                            select new {
                                h.HotelName,
                                h.HotelCity,
                                h.HotelAddress,
                                h.HotelPhone,
                                room.RoomId,
                                room.RoomDescription,
                                room.NumberPeople,
                                room.Price,
                                room.DiscountPrice,
                                room.RoomImage,
                                room.HotelId,
                                room.RoomValid
                            }).Take(5);
                return Ok(_room);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet]
        [Route("GetFavoriteRoomsByIdUser")]
        public IActionResult GetFavoriteRoomsByIdUser(string id)
        {
            try
            {
                int parseId = int.Parse(id);
                var _favoriteRooms =
                    from f in db.Favorites
                    where f.UserId == parseId
                    join r in db.Rooms on f.RoomId equals r.RoomId
                    join h in db.Hotels on r.HotelId equals h.HotelId
                    select new
                    {
                        h.HotelName,
                        h.HotelCity,
                        h.HotelAddress,
                        h.HotelPhone,
                        r.RoomId,
                        r.RoomDescription,
                        r.NumberPeople,
                        r.Price,
                        r.DiscountPrice,
                        r.RoomImage,
                        r.HotelId,
                        r.RoomValid
                    };
                return Ok(_favoriteRooms);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }

        public class AddFavoriteRoomRequest
        {
            public string UserId { get; set; }
            public string RoomId { get; set; }
        }

        [HttpPost]
        [Route("AddFavoriteRoom")]
        public IActionResult AddFavoriteRoom([FromBody] AddFavoriteRoomRequest request)
        {
            try
            {
                int parseUserId = int.Parse(request.UserId);
                int parseRoomId = int.Parse(request.RoomId);
                var favo = db.Favorites.Where(x => x.UserId == parseUserId && x.RoomId == parseRoomId).FirstOrDefault();
                if (favo != null)
                {
                    // favo founded, delete it
                    db.Favorites.Remove(favo);
                    db.SaveChanges();
                    return Ok(new { Status = true, Message = "Bỏ yêu thích thành công" });
                } else
                {
                    // favo not founded, add it
                    Favorite newfavo = new Favorite();
                    newfavo.UserId = parseUserId;
                    newfavo.RoomId = parseRoomId;
                    newfavo.Date = DateTime.Now;
                    db.Favorites.Add(newfavo);
                    db.SaveChanges();
                    return Ok(new { Status = true, Message = "Yêu thích thành công." });
                }
            }
            catch
            {
                return BadRequest();
            }
        }

        [HttpPost]
        [Route("IsFavoriteRoom")]
        public bool CheckIsFavoriteRoom(string roomId, string userId)
        {
            int parseRoomId = int.Parse(roomId);
            int parseUserId = int.Parse(userId);
            var checkRoom = db.Favorites.Where(x => x.RoomId == parseRoomId && x.UserId == parseUserId).FirstOrDefault();
            return checkRoom == null ? false : true ;
        }
        [HttpGet]
        [Route("GetAllRooms")]
        public IActionResult GetRooms()
        {
            var rooms = from r in db.Rooms
                        join h in db.Hotels on r.HotelId equals h.HotelId
                        select new
                        {
                            h.HotelName,
                            h.HotelCity,
                            h.HotelAddress,
                            h.HotelPhone,
                            r.RoomId,
                            r.RoomDescription,
                            r.NumberPeople,
                            r.Price,
                            r.DiscountPrice,
                            r.RoomImage,
                            r.HotelId,
                            r.RoomValid
                        };

            return Ok(rooms);
        }



        [HttpGet]
        [Route("GetBookingDateOfRoom")]
        public IActionResult GetBookingDate(String idRoom)
        {
            int _parseValue = int.Parse(idRoom);
            var rooms = from r in db.Rooms
                        join h in db.Hotels on r.HotelId equals h.HotelId
                        join b in db.Bookings on r.RoomId equals b.RoomId where b.RoomId == _parseValue
                        select new
                        {
                            b.BookingId,
                            b.StartDate,
                            b.EndDate,
                            b.BookingStatus,
                            b.BookingPaid,
                            b.BookingPrice,
                            b.BookingDiscount,
                            b.UserId,
                            b.RoomId,
                            b.BookingDate
                        };
            return Ok(rooms);
        }

        [HttpGet]
        [Route("GetAllBookingRoom")]
        public IActionResult GetAllBookingRoom()
        {
            var bookingRoom = from r in db.Rooms
                              join h in db.Hotels on r.HotelId equals h.HotelId
                              join b in db.Bookings on r.RoomId equals b.RoomId
                              select new
                              {
                                  b.BookingId,
                                  b.StartDate,
                                  b.EndDate,
                                  b.BookingStatus,
                                  b.BookingPaid,
                                  b.BookingPrice,
                                  b.BookingDiscount,
                                  b.UserId,
                                  b.RoomId,
                                  b.BookingDate
                              };
            return Ok(bookingRoom);
        }

    }
}

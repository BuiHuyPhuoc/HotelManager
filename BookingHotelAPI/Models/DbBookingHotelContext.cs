using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace BookingHotelAPI.Models;

public partial class DbBookingHotelContext : DbContext
{
    public DbBookingHotelContext()
    {
    }

    public DbBookingHotelContext(DbContextOptions<DbBookingHotelContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Booking> Bookings { get; set; }

    public virtual DbSet<Hotel> Hotels { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<Room> Rooms { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=LAPTOP-E8TQ0T9U\\SQLEXPRESS;Database=DB_BookingHotel;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Booking>(entity =>
        {
            entity.HasKey(e => e.BookingId).HasName("PK__Booking__73951ACD021E8A50");

            entity.ToTable("Booking");

            entity.HasIndex(e => e.BookingId, "UQ__Booking__73951ACCF2B18E8A").IsUnique();

            entity.Property(e => e.BookingId).HasColumnName("BookingID");
            entity.Property(e => e.BookingPaid).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.BookingPrice).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.BookingStatus).HasMaxLength(255);
        });

        modelBuilder.Entity<Hotel>(entity =>
        {
            entity.HasKey(e => e.HotelId).HasName("PK__Hotel__46023BBF4D1C9A7C");

            entity.ToTable("Hotel");

            entity.HasIndex(e => e.HotelId, "UQ__Hotel__46023BBEB6F2D33E").IsUnique();

            entity.Property(e => e.HotelId).HasColumnName("HotelID");
            entity.Property(e => e.HotelAddress).HasMaxLength(255);
            entity.Property(e => e.HotelCity).HasMaxLength(255);
            entity.Property(e => e.HotelName).HasColumnType("text");
            entity.Property(e => e.HotelPhone)
                .HasMaxLength(10)
                .IsUnicode(false);
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Order__C3905BAFBBE542F4");

            entity.ToTable("Order");

            entity.HasIndex(e => e.OrderId, "UQ__Order__C3905BAEE0A34FCC").IsUnique();

            entity.Property(e => e.OrderId).HasColumnName("OrderID");
            entity.Property(e => e.BookingId).HasColumnName("BookingID");
            entity.Property(e => e.OrderPrice).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.RoomId).HasColumnName("RoomID");
            entity.Property(e => e.UserId).HasColumnName("UserID");
        });

        modelBuilder.Entity<Room>(entity =>
        {
            entity.HasKey(e => e.RoomId).HasName("PK__Room__3286391975B369E8");

            entity.ToTable("Room");

            entity.HasIndex(e => e.RoomId, "UQ__Room__32863918475FC091").IsUnique();

            entity.Property(e => e.RoomId).HasColumnName("RoomID");
            entity.Property(e => e.HotelId).HasColumnName("HotelID");
            entity.Property(e => e.Price).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.RoomDescription).HasMaxLength(255);
            entity.Property(e => e.RoomImage).HasMaxLength(255);
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__User__1788CCACA317C3AE");

            entity.ToTable("User");

            entity.HasIndex(e => e.UserId, "UQ__User__1788CCADD5879C83").IsUnique();

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.UserGmail)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.UserIdcard)
                .HasMaxLength(15)
                .IsUnicode(false)
                .HasColumnName("UserIDCard");
            entity.Property(e => e.UserName).HasMaxLength(100);
            entity.Property(e => e.UserPassword)
                .HasMaxLength(100)
                .IsUnicode(false);
            entity.Property(e => e.UserPhone)
                .HasMaxLength(10)
                .IsUnicode(false);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}

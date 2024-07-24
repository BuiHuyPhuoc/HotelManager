﻿using System;
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

    public virtual DbSet<Favorite> Favorites { get; set; }

    public virtual DbSet<Hotel> Hotels { get; set; }

    public virtual DbSet<LoginDevice> LoginDevices { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderInfo> OrderInfos { get; set; }

    public virtual DbSet<Room> Rooms { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=LAPTOP-E8TQ0T9U\\SQLEXPRESS;Database=DB_BookingHotel;Trusted_Connection=True;TrustServerCertificate=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Booking>(entity =>
        {
            entity.HasKey(e => e.BookingId).HasName("PK__Booking__73951ACDA13EE464");

            entity.ToTable("Booking");

            entity.HasIndex(e => e.BookingId, "UQ__Booking__73951ACCDBE9E8C3").IsUnique();

            entity.Property(e => e.BookingId).HasColumnName("BookingID");
            entity.Property(e => e.BookingDate).HasColumnType("datetime");
            entity.Property(e => e.BookingDiscount).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.BookingPaid).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.BookingPrice).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.BookingStatus).HasMaxLength(255);
            entity.Property(e => e.EndDate).HasColumnType("datetime");
            entity.Property(e => e.RoomId).HasColumnName("RoomID");
            entity.Property(e => e.StartDate).HasColumnType("datetime");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Room).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.RoomId)
                .HasConstraintName("FK__Booking__RoomID__2F10007B");

            entity.HasOne(d => d.User).WithMany(p => p.Bookings)
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__Booking__UserID__2E1BDC42");
        });

        modelBuilder.Entity<Favorite>(entity =>
        {
            entity.HasKey(e => new { e.RoomId, e.UserId }).HasName("PK__Favorite__E3FEB5D3B0F84D32");

            entity.ToTable("Favorite");

            entity.Property(e => e.RoomId).HasColumnName("RoomID");
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.Room).WithMany(p => p.Favorites)
                .HasForeignKey(d => d.RoomId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Favorite__RoomID__36B12243");

            entity.HasOne(d => d.User).WithMany(p => p.Favorites)
                .HasForeignKey(d => d.UserId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("FK__Favorite__UserID__37A5467C");
        });

        modelBuilder.Entity<Hotel>(entity =>
        {
            entity.HasKey(e => e.HotelId).HasName("PK__Hotel__46023BBF581D890C");

            entity.ToTable("Hotel");

            entity.HasIndex(e => e.HotelId, "UQ__Hotel__46023BBE0D204C53").IsUnique();

            entity.Property(e => e.HotelId).HasColumnName("HotelID");
            entity.Property(e => e.HotelAddress).HasMaxLength(255);
            entity.Property(e => e.HotelCity).HasMaxLength(255);
            entity.Property(e => e.HotelName).HasColumnType("text");
            entity.Property(e => e.HotelPhone)
                .HasMaxLength(10)
                .IsUnicode(false);
        });

        modelBuilder.Entity<LoginDevice>(entity =>
        {
            entity
                .HasKey(e => new { e.UserId, e.DeviceToken }).HasName("PK__LoginDevice__E3FEB5D3B0F84D23");
            entity.ToTable("LoginDevice");

            entity.Property(e => e.DeviceToken).IsUnicode(false);
            entity.Property(e => e.UserId).HasColumnName("UserID");

            entity.HasOne(d => d.User).WithMany()
                .HasForeignKey(d => d.UserId)
                .HasConstraintName("FK__LoginDevi__UserI__48CFD27E");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__Order__C3905BAF0A2CF6FA");

            entity.ToTable("Order");

            entity.HasIndex(e => e.OrderId, "UQ__Order__C3905BAED1D31DAF").IsUnique();

            entity.Property(e => e.OrderId).HasColumnName("OrderID");
            entity.Property(e => e.BookingId).HasColumnName("BookingID");
            entity.Property(e => e.OrderDate).HasColumnType("datetime");
            entity.Property(e => e.OrderPrice).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.RoomId).HasColumnName("RoomID");
            entity.Property(e => e.UserId).HasColumnName("UserID");
        });

        modelBuilder.Entity<OrderInfo>(entity =>
        {
            entity.HasKey(e => e.OrderId).HasName("PK__OrderInf__C3905BCF4149B7CA");

            entity.ToTable("OrderInfo");

            entity.Property(e => e.OrderId).ValueGeneratedNever();
            entity.Property(e => e.BankCode).HasMaxLength(50);
            entity.Property(e => e.CreatedDate).HasColumnType("datetime");
            entity.Property(e => e.OrderDesc).HasMaxLength(255);
            entity.Property(e => e.PayStatus).HasMaxLength(50);
            entity.Property(e => e.Status).HasMaxLength(50);
        });

        modelBuilder.Entity<Room>(entity =>
        {
            entity.HasKey(e => e.RoomId).HasName("PK__Room__32863919E35175BD");

            entity.ToTable("Room");

            entity.HasIndex(e => e.RoomId, "UQ__Room__3286391826C5CFB5").IsUnique();

            entity.Property(e => e.RoomId).HasColumnName("RoomID");
            entity.Property(e => e.DiscountPrice).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.HotelId).HasColumnName("HotelID");
            entity.Property(e => e.Price).HasColumnType("decimal(18, 0)");
            entity.Property(e => e.RoomDescription).HasMaxLength(255);
            entity.Property(e => e.RoomImage).HasMaxLength(255);
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.UserId).HasName("PK__User__1788CCACE995824D");

            entity.ToTable("User");

            entity.HasIndex(e => e.UserId, "UQ__User__1788CCAD61DCE79B").IsUnique();

            entity.Property(e => e.UserId).HasColumnName("UserID");
            entity.Property(e => e.DateOfBirth).HasColumnType("datetime");
            entity.Property(e => e.Role)
                .HasMaxLength(12)
                .IsUnicode(false);
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

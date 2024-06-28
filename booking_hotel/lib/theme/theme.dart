import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFFFFFF), // Màu chính (màu thứ hai)
  onPrimary: Color.fromARGB(255, 191, 191, 191), // Màu trên nền primary (trắng)
  secondary: Color(0xFF31363F), // Màu phụ (màu thứ ba)
  onSecondary: Color(0xFFFFFFFF), // Màu trên nền secondary (trắng)
  error: Color(0xFFBA1A1A), // Màu đỏ lỗi (có thể sử dụng màu đỏ mặc định)
  onError: Color(0xFFFFFFFF), // Màu trên nền error (trắng)
  surface: Color(0xFFFFFFFF), // Màu bề mặt (trắng)
  onSurface:
      Color.fromARGB(255, 153, 153, 153), // Màu trên nền surface (màu thứ tư)
  shadow: Color(0xFF000000), // Màu đen (mặc định)
  outline: Color(0xFF737373), // Màu xám
  outlineVariant: Color(0xFFC2C8BC), // Màu xám nhạt
  primaryContainer: Color(0xFFE7E9FD), // Màu container chính (nhạt hơn primary)
  onPrimaryContainer:
      Color(0xFF00278D), // Màu trên container chính (đậm hơn primary)
  secondaryContainer:
      Color(0xFFD9E7F7), // Màu container phụ (nhạt hơn secondary)
  onSecondaryContainer:
      Color(0xFF00447A), // Màu trên container phụ (đậm hơn secondary)
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromARGB(255, 176, 176, 176), // Màu chính (màu thứ hai)
  onPrimary: Color(0xFFFFFFFF), // Màu trên nền primary (trắng)
  secondary: Color(0xFF31363F), // Màu phụ (màu thứ ba)
  onSecondary: Color(0xFFFFFFFF), // Màu trên nền secondary (trắng)
  error: Color(0xFFBA1A1A), // Màu đỏ lỗi (có thể sử dụng màu đỏ mặc định)
  onError: Color(0xFFFFFFFF), // Màu trên nền error (trắng)
  surface: Color(0xFF31363F), // Màu bề mặt (màu thứ ba)
  onSurface:
      Color.fromARGB(255, 35, 35, 35), // Màu trên nền surface (màu thứ nhất)
  shadow: Color(0xFFEEEEEE), // Màu đen (mặc định)
  outline: Color(0xFF737373), // Màu xám
  outlineVariant: Color(0xFF484848), // Màu xám đậm hơn
  primaryContainer: Color(0xFF364A8A), // Màu container chính (đậm hơn primary)
  onPrimaryContainer:
      Color(0xFFD0E1FF), // Màu trên container chính (nhạt hơn primary)
  secondaryContainer:
      Color(0xFF3A556B), // Màu container phụ (đậm hơn secondary)
  onSecondaryContainer:
      Color(0xFFD9E7F7), // Màu trên container phụ (nhạt hơn secondary)
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        lightColorScheme.primary, // Slightly darker shade for the button
      ),
      foregroundColor:
          WidgetStateProperty.all<Color>(Colors.white), // text color
      elevation: WidgetStateProperty.all<double>(5.0), // shadow
      padding: WidgetStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 18)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust as needed
        ),
      ),
    ),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black),
  ),
);

ThemeData darkMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: darkColorScheme,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white70),
  ),
);

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PokedexTheme {
  static ColorScheme colorScheme = const ColorScheme.light(
    primary: Colors.red,
    secondary: Colors.white,
    tertiary: Color.fromARGB(255, 32, 31, 31),
    onPrimary: Colors.white,
  );

  static InputDecorationTheme inputDecorationTheme = const InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
  );

  static TextTheme textTheme = GoogleFonts.poppinsTextTheme();

  static ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(20, 48),
      textStyle: textTheme.bodyMedium,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );

  static OutlinedButtonThemeData outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(20, 48),
      textStyle: textTheme.bodyMedium,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
  );

  static final theme = ThemeData(
    inputDecorationTheme: inputDecorationTheme,
    colorScheme: colorScheme,
    textTheme: textTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
  );
}

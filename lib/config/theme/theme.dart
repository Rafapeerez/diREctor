import 'package:flutter/material.dart';

const Color BUTTONS_COLOR = Color.fromRGBO(230, 238, 255, 1.0);

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  });

  ThemeData getTheme() {
    const ColorScheme lightColorScheme = ColorScheme.light(
      primary: Color(0xFF375CA8),
      secondary: BUTTONS_COLOR,
    );

    const ColorScheme darkColorScheme = ColorScheme.dark(
      primary: Color(0xFF375CA8),
      secondary: BUTTONS_COLOR,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: isDarkMode ? darkColorScheme : lightColorScheme,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: isDarkMode ? darkColorScheme.primary : lightColorScheme.primary,
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: isDarkMode ? darkColorScheme.secondary : lightColorScheme.secondary,
      ),
    );
  }
  // ThemeData getTheme() {
  //   return ThemeData(
  //       useMaterial3: true,
  //       brightness: isDarkMode ? Brightness.dark : Brightness.light,
  //       colorSchemeSeed: const Color.fromRGBO(118, 151, 229, 1),
  //       appBarTheme: const AppBarTheme(
  //         centerTitle: false,
  //       ));
  // }

  AppTheme copyWith({int? selectedColor, bool? isDarkMode}) => AppTheme(
      selectedColor: this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode);
}

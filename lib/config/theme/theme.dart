import 'package:flutter/material.dart';


class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  });

  ThemeData getTheme() {
    return ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: const Color.fromRGBO(118, 151, 229, 1),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
        ));
  }

  //Importante para tener las propiedades final y el estado inmutable. MUY UTIL
  AppTheme copyWith({
      int? selectedColor, 
      bool? isDarkMode
    }) => AppTheme(
      selectedColor: this.selectedColor,
      isDarkMode: isDarkMode ?? this.isDarkMode
    );
}

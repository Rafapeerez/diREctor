import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  final ThemeData _lightTheme = ThemeData.light().copyWith(
    primaryColor: const Color.fromRGBO(118, 151, 229, 1),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(118, 151, 229, 1))
  );

  final ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: const Color.fromRGBO(118, 151, 229, 1),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(118, 151, 229, 1)),
  );

  ThemeData _currentTheme = ThemeData.light().copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(118, 151, 229, 1))
  );
  
  AppTheme() {
    _currentTheme = _currentTheme.copyWith(

      brightness: Brightness.light, 
    );
  }

  ThemeData getTheme() {
    return _currentTheme;
  }

  void setTheme(bool isDark) {
    _currentTheme = isDark ? _darkTheme : _lightTheme;
    notifyListeners();
  }
}

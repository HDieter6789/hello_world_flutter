import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  double _fontSize = 16.0;

  ThemeMode get themeMode => _themeMode;
  double get fontSize => _fontSize;

  void toggleTheme(bool isDarkMode) {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setFontSize(String size) {
    switch (size) {
      case 'Klein':
        _fontSize = 14.0;
        break;
      case 'Mittel':
        _fontSize = 16.0;
        break;
      case 'Groß':
        _fontSize = 20.0;
        break;
      default:
        _fontSize = 16.0;
    }
    notifyListeners();
  }
}

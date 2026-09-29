import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  Brightness _brightness = Brightness.dark;
  Color _seedColor = Colors.red;
  Color get colorSeed => _seedColor;

  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: _brightness,
    ),
  );

  void toggleDarkMode(bool darkmode) {
    _brightness = darkmode ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  void setColorSeed(Color seed) {
    _seedColor = seed;
    notifyListeners();
  }
}

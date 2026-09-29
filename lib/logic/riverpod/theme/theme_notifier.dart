// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  Brightness _brightness = Brightness.dark;
  Color _seedColor = Colors.red;

  /// The currently used Color seed
  Color get colorSeed => _seedColor;

  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: _brightness,
    ),
  );

  /// toggles darkmode on & off
  void toggleDarkMode(bool darkmode) {
    _brightness = darkmode ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  /// set the color seed
  void setColorSeed(Color seed) {
    _seedColor = seed;
    notifyListeners();
  }
}

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends Notifier<ThemeData> {
  Color _colorSeed = Colors.blue;
  @override
  ThemeData build() => ThemeData(colorSchemeSeed: _colorSeed);

  /// The currently used Color seed

  /// toggles darkmode on & off
  void toggleDarkMode(bool darkmode) {
    state = state.copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _colorSeed,
        brightness: darkmode ? Brightness.dark : Brightness.light,
      ),
    );
    // _brightness = darkmode ? Brightness.dark : Brightness.light;
  }

  /// set the color seed
  void setColorSeed(Color seed) {
    _colorSeed = seed;
    state = state.copyWith(colorScheme: ColorScheme.fromSeed(seedColor: seed));
  }
}

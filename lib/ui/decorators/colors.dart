import 'package:flutter/material.dart';

/// An attempt to build a color scheme for the app
class AppColors {
  /// pass a context to get the themedata
  final BuildContext context;

  AppColors(this.context);

  Color get customerTileBackground =>
      Theme.of(context).colorScheme.secondaryContainer;

  Color getCustomerOuter(bool selected) => selected
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.inversePrimary;
}

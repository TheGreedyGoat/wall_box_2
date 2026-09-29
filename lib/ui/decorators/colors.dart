import 'package:flutter/material.dart';

class AppColors {
  final BuildContext context;

  AppColors(this.context);

  Color get customerTileBackground =>
      Theme.of(context).colorScheme.secondaryContainer;

  Color getCustomerOuter(bool selected) => selected
      ? Theme.of(context).colorScheme.primary
      : Theme.of(context).colorScheme.inversePrimary;
}

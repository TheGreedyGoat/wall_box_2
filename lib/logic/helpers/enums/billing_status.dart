import 'package:flutter/material.dart';

enum BillingStatus {
  open,
  billed;

  Color get baseColor => switch (this) {
    BillingStatus.open => Colors.red,
    BillingStatus.billed => Colors.green,
  };
  Color get backgroundColor =>
      HSVColor.fromColor(baseColor).withSaturation(0.7).toColor();

  Color get foreGroundColor => HSVColor.fromColor(
    baseColor,
  ).withValue(0.75).toColor();
}

import 'package:flutter/material.dart';

class NavigationItem {
  final Widget icon;
  final Widget destination;
  final String title;

  NavigationItem({
    required this.icon,
    required this.destination,
    required this.title,
  });
}

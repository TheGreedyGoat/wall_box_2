import 'package:flutter/material.dart';

/// creates a page that is split in two parts eg or left-side menus.
///
/// The default value for leftWidth is used fpor customerTiles
class SplitPage extends StatelessWidget {
  /// The Widget to show on the left side. This will have a fixed Width defined by [leftWidth]
  final Widget left;

  /// The with to set for the left Widget
  final double leftWidth;

  /// The Widget to show on the right side. Expands to the remaining spage
  final Widget right;

  /// creates a page that is split in two parts eg or left-side menus.
  ///
  /// The default value for leftWidth is used fpor customerTiles
  const SplitPage({
    super.key,
    required this.left,
    required this.right,
    this.leftWidth = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: leftWidth, child: left),
        Expanded(
          child: right,
        ),
      ],
    );
  }
}

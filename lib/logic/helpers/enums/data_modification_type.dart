import 'package:flutter/material.dart';

/// represents if and how some data were modified.
///
/// Use to assign corresponding styles within the ui
enum DataModificationType {
  ///
  unmodified,

  ///
  modified,

  ///
  removed,

  ///
  added;

  /// color representation of teh modification
  Color color(BuildContext context) => switch (this) {
    DataModificationType.unmodified => Theme.of(context).colorScheme.surfaceDim,
    DataModificationType.modified => Colors.deepOrangeAccent,
    DataModificationType.removed => Colors.blueGrey,
    DataModificationType.added => Colors.lightGreen,
  };
}

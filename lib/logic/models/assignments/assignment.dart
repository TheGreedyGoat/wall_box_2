import 'package:wall_box_2/logic/helpers/interval.dart';

/// super class for assignment data
abstract class Assignment {
  /// returns when this assignment starts
  DateTime get from;

  /// returns when this assignment ends. null usually means the assignment is still active
  /// (basiaclly to == now)
  DateTime? get to;

  /// super class for assignment data
  const Assignment();

  ///
  DateTime get toOrNow => to ?? DateTime.now();

  /// converts the dates into an interval object
  Interval get interval => Interval(from: from, to: toOrNow);
}

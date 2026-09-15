import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';

abstract class Assignment {
  DateTime get from;
  DateTime? get to;

  const Assignment();

  DateTime get toOrNow => to ?? DateTime.now();
  @override
  Interval get interval => Interval(from: from, to: toOrNow);
}

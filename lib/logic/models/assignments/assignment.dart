import 'package:wall_box_2/logic/helpers/interval.dart';

class Assignment {
  final DateTime from;
  final DateTime? to;

  const Assignment({required this.from, this.to});

  DateTime get toOrNow => to ?? DateTime.now();
  Interval get interval => Interval(from: from, to: toOrNow);
}

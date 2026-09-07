/// Describes a time interval in between two DateTimes
class Interval {
  /// The start timestamp
  final DateTime from;

  /// the end timestamp
  final DateTime to;

  /// Describes a time interval in between two DateTimes
  const Interval({required this.from, required this.to});

  ///creates an Interval of a given [Duration] ending at [to]
  ///
  factory Interval.durationTo({
    required DateTime to,
    required Duration durationBefore,
  }) => Interval(from: to.subtract(durationBefore), to: to);

  /// creates an Interval of a given [Duration] starting at [from]
  factory Interval.durationFrom({
    required DateTime from,
    required Duration durationAfter,
  }) => Interval(from: from, to: from.add(durationAfter));
}

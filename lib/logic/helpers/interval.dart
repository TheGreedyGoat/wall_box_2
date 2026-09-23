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

  /// returns the duration of the interval
  ///
  /// (similar to the norm as the length of a vector)
  Duration get duration => to.difference(from);

  /// returns true, if [date] is within the interval (exclusive bounds)
  bool containsDate(DateTime date) => date.isAfter(from) && date.isBefore(to);

  /// returns true, if the two Interval overlap each other (<=> they share at least one point in time)
  bool intersects(Interval other) =>
      containsDate(other.from) || other.containsDate(from);

  /// returns true, if [other] is a subinterval of this
  bool contains(Interval other) =>
      containsDate(other.from) && containsDate(other.to);

  /// returns true, if this is a subInterval of [other] (so i'ts the reverse of [contains])
  bool isSubInterval(Interval other) => other.contains(this);

  @override
  bool operator ==(Object other) =>
      other is Interval && other.from == from && other.to == to;

  @override
  int get hashCode => from.hashCode ^ to.hashCode;
}

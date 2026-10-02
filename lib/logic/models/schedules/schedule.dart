import 'package:wall_box_2/logic/helpers/interval.dart';

abstract class Schedule {
  final DateTime firstDate;
  final DateTime? lastDate;
  Schedule({required this.firstDate, this.lastDate});

  List<DateTime> getAppointments(TimeInterval interval);
  TimeInterval get interval =>
      TimeInterval(from: firstDate, to: lastDate ?? DateTime.now());
}

class ScheduleDuration extends Schedule {
  final Duration duration;

  ScheduleDuration({
    required super.firstDate,
    super.lastDate,
    required this.duration,
  });

  ScheduleDuration.byDays({
    required super.firstDate,
    super.lastDate,
    required int days,
  }) : duration = Duration(days: days);
  ScheduleDuration.byWeeks({
    required super.firstDate,
    super.lastDate,
    required int weeks,
  }) : duration = Duration(days: weeks * 7);

  @override
  List<DateTime> getAppointments(TimeInterval interval) {
    final start = firstDate;
    final end = lastDate ?? interval.to;
    TimeInterval(from: start, to: end).intersection(interval)?.days ?? [];
    if (!TimeInterval(from: start, to: end).intersects(interval)) {
      return [];
    }

    return [
      for (DateTime date = start; date.isBefore(end); date = date.add(duration))
        date,
    ];
  }
}

class ScheduleMonthly extends Schedule {
  final List<int> days;
  final bool ensureWorkday;
  ScheduleMonthly({
    required super.firstDate,
    required this.days,
    super.lastDate,
    this.ensureWorkday = false,
  });

  @override
  List<DateTime> getAppointments(TimeInterval interval) {
    final dates = interval.days.where(
      (day) {
        return this.interval.containsDate(day) && this.days.contains(day.day);
      },
    ).toList();
    return ensureWorkday
        ? dates.map(
            (date) {
              while (date.weekday >= 6) {
                date = date.add(Duration(days: 1));
              }
              return date;
            },
          ).toList()
        : dates;
  }
}

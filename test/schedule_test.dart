import 'package:flutter_test/flutter_test.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/models/schedules/schedule.dart';

void main() {
  group('ScheduleDuration', () {
    test('uses the requested interval when schedule bounds are omitted', () {
      final Schedule schedule = ScheduleDuration(
        firstDate: DateTime(2025, 1, 1),
        duration: const Duration(days: 2),
      );
      final interval = TimeInterval(
        from: DateTime(2025, 1, 1),
        to: DateTime(2025, 1, 6),
      );

      expect(schedule.getAppointments(interval), [
        DateTime(2025, 1, 1),
        DateTime(2025, 1, 3),
        DateTime(2025, 1, 5),
      ]);
    });

    test('uses configured bounds and excludes the last date', () {
      final schedule = ScheduleDuration(
        firstDate: DateTime(2025, 1, 2),
        lastDate: DateTime(2025, 1, 8),
        duration: const Duration(days: 2),
      );
      final interval = TimeInterval(
        from: DateTime(2025, 1, 1),
        to: DateTime(2025, 1, 10),
      );

      expect(schedule.getAppointments(interval), [
        DateTime(2025, 1, 2),
        DateTime(2025, 1, 4),
        DateTime(2025, 1, 6),
      ]);
    });

    test('byDays creates appointments at the requested day interval', () {
      final schedule = ScheduleDuration.byDays(
        firstDate: DateTime(2025, 1, 1),
        lastDate: DateTime(2025, 1, 10),
        days: 3,
      );

      expect(
        schedule.getAppointments(
          TimeInterval(from: DateTime(2025, 1, 1), to: DateTime(2025, 1, 10)),
        ),
        [DateTime(2025, 1, 1), DateTime(2025, 1, 4), DateTime(2025, 1, 7)],
      );
    });

    test('byWeeks creates appointments seven days apart per week', () {
      final schedule = ScheduleDuration.byWeeks(
        firstDate: DateTime(2025, 1, 1),
        lastDate: DateTime(2025, 1, 22),
        weeks: 1,
      );

      expect(
        schedule.getAppointments(
          TimeInterval(from: DateTime(2025, 1, 1), to: DateTime(2025, 1, 22)),
        ),
        [DateTime(2025, 1, 1), DateTime(2025, 1, 8), DateTime(2025, 1, 15)],
      );
    });

    test(
      'returns no appointments when schedule and interval do not overlap',
      () {
        final schedule = ScheduleDuration(
          firstDate: DateTime(2025, 1, 1),
          lastDate: DateTime(2025, 1, 5),
          duration: const Duration(days: 1),
        );
        expect(
          schedule.getAppointments(
            TimeInterval(from: DateTime(2025, 1, 6), to: DateTime(2025, 1, 10)),
          ),
          isEmpty,
        );
      },
    );
  });

  group(
    'Schedule Monthly',
    () {
      test(
        'Monthly Schedule filters correctly by dates',
        () {
          final schedule = ScheduleMonthly(
            firstDate: DateTime(2025, 1, 1),
            days: [1, 15],
          );

          final interval = TimeInterval(
            from: DateTime(2025, 1, 1),
            to: DateTime(2025, 3, 1),
          );
          expect(
            schedule.getAppointments(interval),
            equals([
              DateTime(2025, 1, 1),
              DateTime(2025, 1, 15),
              DateTime(2025, 2, 1),
              DateTime(2025, 2, 15),
            ]),
          );
        },
      );
    },
  );
}

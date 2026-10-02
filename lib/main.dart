import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';
import 'package:my_utils/utility/enums/months.dart';
import 'package:wall_box_2/data/repositories/transaction_repo.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/models/schedules/schedule.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wall_box_2/ui/pages/root/widget_tree_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _initDataBase();
  await debugStuff();
  runApp(ProviderScope(child: MainApp()));
}

///f
///
class MainApp extends ConsumerWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ref
          .watch(themeProvider)
          .copyWith(dividerTheme: DividerThemeData(color: Colors.grey)),
      home: WidgetTreeRoot(),
    );
  }
}

List<TimeInterval> months() {
  return Month.values.map(
    (e) {
      return TimeInterval.month(e.index + 1, 2026);
    },
  ).toList();
}

Future<List<TimeInterval>> transactionIntervals() async {
  final result = (await TransactionRepo(onchanged: null).queryAsObjects())
      .map(
        (ta) => ta.interval,
      )
      .toList();

  // result.shuffle();
  return result;
}

void _initDataBase() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}

Future<void> debugStuff() async {
  final schedule1 = ScheduleMonthly(firstDate: DateTime(2026, 1, 1), days: [3]);
  final schedule2 = ScheduleMonthly(
    firstDate: DateTime(2026, 1, 1),
    days: [3],
    ensureWorkday: true,
  );
  print(
    schedule1
        .getAppointments(
          TimeInterval.durationFrom(
            from: DateTime(2026, 1, 1),
            durationAfter: Duration(days: 40),
          ),
        )
        .map(
          (date) {
            return date.toDynamicString('~wd, ~DD.~MM.~YY');
          },
        )
        .toList(),
  );
  print(
    schedule2
        .getAppointments(
          TimeInterval.durationFrom(
            from: DateTime(2026, 1, 1),
            durationAfter: Duration(days: 40),
          ),
        )
        .map(
          (date) {
            return date.toDynamicString('~WD, ~DD.~MM.~YY');
          },
        )
        .toList(),
  );
}

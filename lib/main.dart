import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_utils/utility/enums/months.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';
import 'package:wall_box_2/data/repositories/transaction_repo.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wall_box_2/ui/pages/root/widget_tree_root.dart';
import 'package:wall_box_2/ui/visualisations/show_intervals.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(ProviderScope(child: MainApp()));
}

///
class MainApp extends ConsumerWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ref.watch(themeProvider),
      home: WidgetTreeRoot(),
      // FutureBuilder(
      //   future: transactionIntervals(),
      //   builder: (context, snapshot) {
      //     return snapshot.hasData
      //         ? ShowIntervals(
      //             intervals: months(),
      //             totalWidth: 2500,
      //           )
      //         : Placeholder();
      //   },
      // ),
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

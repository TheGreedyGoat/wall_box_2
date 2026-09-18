// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';
import 'package:wall_box_2/data/repositories/tag_assignment_repo.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/email.dart';
import 'package:wall_box_2/logic/models/master_data/contact/phone.dart';
import 'package:wall_box_2/logic/models/master_data/personal/personal_data.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/services/global.dart';
import 'package:wall_box_2/ui/dummy/upload_and_parse.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wall_box_2/ui/pages/customer_overview.dart';
import 'package:wall_box_2/ui/pages/enter_customer_data.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/tag_assignments/customer_tag_assignments.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // final db = await AppDatabase.instance.queryAll();
  // for (final e in db) {
  //   print(e.toString());
  // }
  // await AppDatabase.instance.delete();
  // await TagAssignmentRepo(
  //   onchanged: () {},
  // ).insert(
  //   TagAssignment(
  //     tagID: 'jhdjudasdasd8378342',
  //     customerID: '66d899a0-b105-11f1-9992-654532a269db',
  //     from: DateTime(2026, 2, 3),
  //     to: DateTime.now(),
  //   ),
  // );
  runApp(ProviderScope(child: MainApp()));
}

///
class MainApp extends ConsumerWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      // locale: const Locale('de'),
      // supportedLocales: [
      //   Locale('de'),
      //   Locale('en'),
      // ],
      home: CustomerOverview(),
    );
  }
}

// ignore_for_file: unused_import

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';
import 'package:wall_box_2/data/interface_models/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/customer.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/email.dart';
import 'package:wall_box_2/logic/models/master_data/contact/phone.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';
import 'package:wall_box_2/logic/services/global.dart';
import 'package:wall_box_2/ui/dummy/upload_and_parse.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wall_box_2/ui/pages/enter_customer_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  await AppDatabase.instance.delete();
  runApp(ProviderScope(child: MainApp()));
}

///
class MainApp extends StatelessWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: EnterCustomerData(),
      ),
    );
  }
}

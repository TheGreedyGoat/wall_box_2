// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/customer.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/email.dart';
import 'package:wall_box_2/logic/models/master_data/contact/phone.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';
import 'package:wall_box_2/logic/services/global.dart';
import 'package:wall_box_2/ui/dummy/upload_and_parse.dart';

void main() {
  final c = Customer(
    id: 'id',
    company: CompanyData(id: 'id'),
    personal: PersonalData(id: 'id'),
  );
  print(c.validate());
  print(c.toString());
}

///
class MainApp extends StatelessWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: UploadAndParse(),
        ),
      ),
    );
  }
}

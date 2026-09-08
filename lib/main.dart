import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';
import 'package:wall_box_2/ui/dummy/upload_and_parse.dart';

void main() {
  final d = PersonalData(
    id: "abcdefghijklmnop",
    prename: 'Kevin',
    surname: 'Rivas',
  );
  print(d.validate());
  runApp(MainApp());
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

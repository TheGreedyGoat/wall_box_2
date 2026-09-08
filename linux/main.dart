// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/dummy/upload_and_parse.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: UploadAndParse(),
      ),
    );
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/parser/wall_box_log.dart';
import 'package:wall_box_2/logic/parser/wall_box_parser.dart';
import 'package:wall_box_2/ui/dummy/ta_block_display.dart';

class UploadAndParse extends StatefulWidget {
  const UploadAndParse({super.key});

  @override
  State<UploadAndParse> createState() => _UploadAndParseState();
}

class _UploadAndParseState extends State<UploadAndParse> {
  WallBoxLog? log;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () async {
            processFile(
              await FilePicker.pickFiles(
                dialogTitle: 'Logdatei wählen',
                type: FileType.custom,
                allowedExtensions: ['csv'],
              ),
            );
          },
          child: Text('Hochladen'),
        ),
        if (log != null)
          Expanded(
            child: ListView(
              children: [
                ...log!.blocks.map(
                  (ta) => TaBlockDisplay(
                    block: ta,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void processFile(List<PlatformFile> files) async {
    final logs = await WallBoxParser.processFilePickerResult(
      files,
      (fileName) async {},
      (content, fileName) async {
        return false;
      },
    );
    setState(() {
      log = logs.firstOrNull;
    });
  }
}

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/logs/log_file.dart';
import 'package:wall_box_2/logic/models/logs/transaction_log.dart';

class UploadAndParse extends StatefulWidget {
  const UploadAndParse({super.key});

  @override
  State<UploadAndParse> createState() => _UploadAndParseState();
}

class _UploadAndParseState extends State<UploadAndParse> {
  LogFile? file;

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
        if (file != null)
          Expanded(
            child: ListView(
              children: [
                ...file!.transactions.map(
                  (ta) => Card(
                    child: Column(
                      children: [
                        ListTile(
                          leading: Text('Start'),
                          title: Text(
                            ta.startLine?.timeStamp.toString() ?? 'ERROR',
                          ),
                          subtitle: Text(
                            ta.startLine?.powerLevel.toString() ?? 'ERROR',
                          ),
                          trailing: Text(ta.tagId),
                        ),
                        ...ta.mvLines.map(
                          (mv) => Padding(
                            padding: const EdgeInsetsGeometry.only(left: 16.0),

                            child: ListTile(
                              leading: Text('MV'),
                              title: Text(
                                mv.timeStamp.toString(),
                              ),
                              subtitle: Text(
                                mv.powerLevel.toString(),
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          leading: Text('Stop'),
                          title: Text(
                            ta.stopLine?.timeStamp.toString() ?? 'ERROR',
                          ),
                          subtitle: Text(
                            ta.stopLine?.powerLevel.toString() ?? 'ERROR',
                          ),
                          trailing: Text(ta.tagId),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void processFile(List<PlatformFile> files) async {
    if (files.isEmpty) return;
    String? content = await File(files[0].path ?? '').readAsString();

    setState(() {
      file = LogFile.parse(content);
    });
  }
}

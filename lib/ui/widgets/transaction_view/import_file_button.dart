import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/data/repositories/known_logs_repo.dart';
import 'package:wall_box_2/logic/models/transaction.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/services/parser/wall_box_parser.dart';

class ImportFileButton extends ConsumerStatefulWidget {
  const ImportFileButton({super.key});

  @override
  ConsumerState<ImportFileButton> createState() => _ImportFileButtonState();
}

class _ImportFileButtonState extends ConsumerState<ImportFileButton> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        importFile();
      },
      icon: Icon(Icons.upload_file),
      tooltip: 'Neue Datei einlesen',
    );
  }

  void importFile() async {
    final files = await FilePicker.pickFiles(
      dialogTitle: 'Logdatei wählen',
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );
    final logs = await WallBoxParser.instance.processFilePickerResult(
      files,
      onLineError: (content, fileName) async {
        return false;
      },
      onLogAlreadyExists: (fileName) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Log-Datei wurde bereits eingelesen'),
              content: Text('Die Datei $fileName wird übersprungen'),
            );
          },
        );
      },
    );
    final newTas = List<Transaction>.empty(growable: true);

    final logsRepo = KnownLogsRepo(
      onchanged: () {},
    );
    for (final log in logs) {
      await logsRepo.insert(log.head);
      newTas.addAll(
        log.createTransactions(),
      );
    }
    final changes = await ref.read(transactionRepoProvider).insertAll(newTas);
    if (changes == 0 || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaktionen erfolgreich eingelesen')),
    );
  }
}

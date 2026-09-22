import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/data/repositories/known_logs_repo.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_log.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_transaction_block/wall_box_transaction_block.dart';
import 'package:wall_box_2/logic/models/transaction.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/services/parser/wall_box_parser.dart';
import 'package:wall_box_2/ui/dummy/ta_block_display.dart';

/// Test Widget
class UploadAndParse extends ConsumerStatefulWidget {
  /// Test Widget
  const UploadAndParse({super.key});

  @override
  ConsumerState<UploadAndParse> createState() => _UploadAndParseState();
}

class _UploadAndParseState extends ConsumerState<UploadAndParse> {
  @override
  Widget build(BuildContext context) {
    final transactionsFut = ref.watch(transactionRepoProvider).getMultiple();
    return Scaffold(
      body: Column(
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
          FutureBuilder(
            future: transactionsFut,
            builder: (context, snapshot) {
              final data = snapshot.data;
              final content = (data ?? []).isNotEmpty
                  ? data!
                        .map(
                          (ta) => TaBlockDisplay(
                            transaction: ta,
                          ),
                        )
                        .toList()
                  : [
                      Card(
                        child: ListTile(
                          title: Text('nüscht'),
                        ),
                      ),
                    ];
              return Expanded(
                child: ListView(
                  children: content,
                ),
              );
            },
          ),
          // if (transactions != null)
        ],
      ),
    );
  }

  void processFile(List<PlatformFile> files) async {
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
      logsRepo.insert(log.head);
      newTas.addAll(
        log.createTransactions(),
      );
    }
    final changes = await ref.read(transactionRepoProvider).insertAll(newTas);
    if (changes == 0) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Transaktionen erfolgreich eingelesen')),
    );
  }
}

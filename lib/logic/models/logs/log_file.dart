import 'package:wall_box_2/logic/models/logs/transaction_log.dart';

/// Reperesents the content of one log file
class LogFile {
  static RegExp get deviceLineRegexp => RegExp(r'\# Device, *(.*)');
  static RegExp get genDateLineRegexp => RegExp(r'\# Generated, *(.*)');
  static RegExp get fullTransactionRegExp => RegExp(
    r'txstart[^\r\n]*\r?\n'
    r'(?:mv[^\r\n]*\r?\n)*'
    r'txstop[^\r\n]*(?:\r?\n|$)',
  );

  /// The Device id of the source Wallbox
  final String wallboxID;

  /// When was this file generated?
  final DateTime generationDate;

  /// found transactionnlogs
  final List<TransactionLog> transactions;

  /// Reperesents the content of one log file
  LogFile({
    required this.wallboxID,
    required this.generationDate,
    required this.transactions,
  });

  String get raw => transactions.fold(
    '',
    (previousValue, ta) => '${ta.raw}\n',
  );

  factory LogFile.parse(String raw) {
    String deviceID = deviceLineRegexp.firstMatch(raw)?.group(1) ?? 'FEHLER';
    final dateRaw = genDateLineRegexp
        .firstMatch(raw)!
        .group(1)!
        .replaceAll('.', '-');

    final split = dateRaw.split(' ');
    final dateDate = split[0]
        .split('-')
        .map(
          (e) => int.parse(e),
        )
        .toList();
    final dateTime = split[1]
        .split(':')
        .map(
          (e) => int.parse(e),
        )
        .toList();
    DateTime generationDate = DateTime(
      dateDate.last,
      dateDate[1],
      dateDate[0],
      dateTime[0],
      dateTime[1],
      dateTime[2],
    );
    final transactions = List<TransactionLog>.empty(growable: true);

    final fullTransactionsRaw = fullTransactionRegExp.allMatches(raw).toList();
    for (final block in fullTransactionsRaw) {
      transactions.add(TransactionLog.parseFullBlock(block.group(0)!));
    }

    return LogFile(
      wallboxID: deviceID,
      generationDate: generationDate,
      transactions: transactions,
    );
  }
}

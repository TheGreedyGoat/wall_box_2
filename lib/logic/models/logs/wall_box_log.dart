import 'package:wall_box_2/logic/models/transaction.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_line/wall_box_line.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_transaction_block/wall_box_transaction_block.dart';

/// identifies the 3 possible line types within a log file
enum LineType {
  /// The type every transaction starts with
  start,

  /// The type every transaction ends with
  stop,

  /// Interim status lines
  mv,
}

/// Provides regular expressions for relevant type of data within a log file
enum DataType {
  /// head of the file, the Wall Box' id
  deviceID(r'\# Device, *(.*)'),

  /// head of File, the moment the file was generated
  ///
  /// (Yes, needs an extra regexp, because the logs use 2 different date formats. GNARF...)
  generationDate(
    r'\# Generated, *(\d{2})\.(\d{2})\.(\d{4}) (\d{2}):(\d{2}):(\d{2})',
  ),

  /// The date format used within the log lines themslves
  date(r'\d{4}(\-\d{2}){2} \d{2}(:\d{2}){2}'),

  /// power usage
  power(r'\d+\.\d{2,3}'),

  /// tag id
  tagID(r'[0-9A-Z]{5,}');

  /// the source String for the RegExp
  final String regExSource;

  /// the full Regecp
  RegExp get regexp => RegExp(regExSource);
  const DataType(this.regExSource);
}

/// RegExp to find the tag of a start-line
RegExp startExp = RegExp(r'txstart');

/// RegExp to find the tag of a stop-line
RegExp stopExp = RegExp(r'txstop');

/// RegExp to find the tag of a mv-line
RegExp mvExp = RegExp(r'mv');

/// Represents one whole file
class WallBoxLog {
  /// The transaction blocks parsed from the log
  late final List<WallBoxTransactionBlock> blocks;

  /// The first two lines of the log file.
  ///
  /// Contains the device ID and generation date
  late final String head;

  /// When did this log get generated?
  DateTime get generationDate {
    final match = RegExp(
      DataType.generationDate.regExSource,
    ).allMatches(head).first;
    final year = int.parse(
      match.group(3)!,
    );
    final month = int.parse(
      match.group(2)!,
    );
    final day = int.parse(
      match.group(1)!,
    );
    final hour = int.parse(
      match.group(4)!,
    );
    final min = int.parse(
      match.group(5)!,
    );
    final sec = int.parse(
      match.group(6)!,
    );
    return DateTime(year, month, day, hour, min, sec);
  }

  /// Wich wallbox does this originate from?
  String? get deviceID {
    return RegExp(
      DataType.deviceID.regExSource,
    ).allMatches(head).firstOrNull?.group(1);
  }

  WallBoxLog._(this.blocks, this.head);

  /// tries parsing [WallBoxLine]s from [source]
  ///
  /// use [onLineError] to specify if the parsing process should be continued (and the error transaction just skipped)
  /// when a line error occurs
  ///
  static Future<WallBoxLog?> fromSource(
    String source,
    Future<bool> Function(String) onLineError,
  ) async {
    final split = source.split('\n');
    final head = '${split[0]}\n${split[1]}';
    List<WallBoxTransactionBlock> blocks = List.empty(growable: true);
    for (int i = 2; i < split.length; i++) {
      if (split[i].isEmpty) continue;
      MainLine? start;
      MainLine? stop;
      final List<MVLine> mvs = List.empty(growable: true);
      int j = i;
      for (; j < split.length; j++) {
        if (split[j].isEmpty) continue;
        bool shouldBreak = false;
        WallboxLine? parsed = WallboxLine.tryParse(split[j]);
        if (parsed == null) {
          if (await onLineError(split[j])) {
            return null;
          }
          break;
        }
        switch (parsed.type) {
          case LineType.start:
            assert(start == null, '$i, $j');
            start = parsed as MainLine;
            break;
          case LineType.mv:
            mvs.add(parsed as MVLine);
            break;
          case LineType.stop:
            stop = parsed as MainLine;
            shouldBreak = true;
            break;
        }
        if (shouldBreak) {
          break;
        }
      }
      final prototype = WallBoxLog._([], head);
      blocks.add(
        WallBoxTransactionBlock(
          start: start,
          mvLines: mvs,
          stop: stop,
          deviceID: prototype.deviceID ?? 'ERROR',
        ),
      );
      i = j;
    }
    return WallBoxLog._(blocks.toList(growable: false), head);
  }

  @override
  String toString() => head;

  /// Reassambles the full string as it was written in the log file.
  String get raw => blocks.fold(
    '$head\n',
    (previousValue, element) => '$previousValue${element.toString()}\n',
  );

  /// converts all possible transactionblocks into actual Transaction instances
  void createTransactions() {
    List<Transaction> result = List.empty(growable: true);
    for (final block in blocks) {
      Transaction? fromBlock = block.tryGetTransaction;
      if (fromBlock != null && fromBlock.usage.value != 0) {
        result.add(fromBlock);
      }
    }
  }

  @override
  bool operator ==(Object other) => other is WallBoxLog && other.head == head;
  @override
  int get hashCode => 'WallBoxLog'.hashCode ^ head.hashCode;
}

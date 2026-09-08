import 'package:wall_box_2/logic/models/wall_box_transaction.dart';
import 'package:wall_box_2/logic/parser/wall_box_line/wall_box_line.dart';
import 'package:wall_box_2/logic/parser/wall_box_transaction_block/wall_box_transaction_block.dart';

enum LineType { start, stop, mv }

Map<LineType, List<LineType>> successors = {
  LineType.start: [LineType.mv],
  LineType.stop: [LineType.start],
  LineType.mv: [LineType.mv, LineType.stop],
};

enum DataType {
  deviceID(r'\# Device, *(.*)'),
  generationDate(
    r'\# Generated, *(\d{2})\.(\d{2})\.(\d{4}) (\d{2}):(\d{2}):(\d{2})',
  ),
  date(r'\d{4}(\-\d{2}){2} \d{2}(:\d{2}){2}'),
  power(r'\d+\.\d{2,3}'),
  tagID(r'[0-9A-Z]{5,}');

  final String regExSource;
  const DataType(this.regExSource);
}

RegExp startExp = RegExp(r'txstart');
RegExp stopExp = RegExp(r'txstop');
RegExp mvExp = RegExp(r'mv');

class WallBoxLog {
  WallBoxLog._(this.blocks, this.head);
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

  String? get deviceID {
    return RegExp(
      DataType.deviceID.regExSource,
    ).allMatches(head).firstOrNull?.group(1);
  }

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

  late final List<WallBoxTransactionBlock> blocks;
  late final String head;

  String get fileName => 'transactions_${deviceID}_$generationDate';

  @override
  String toString() => blocks.fold(
    '',
    (previousValue, element) => '${previousValue}${element.toString()}\n',
  );

  void createTransactions() {
    List<WallBoxTransaction> result = List.empty(growable: true);
    for (final block in blocks) {
      WallBoxTransaction? fromBlock = block.tryGetTransaction;
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

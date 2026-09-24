import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/incomplete_blocks_table.dart';
import 'package:wall_box_2/data/repositories/incomplete_blocks_repo.dart';
import 'package:wall_box_2/logic/helpers/units/kilo_watt_hour.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_log.dart';
import 'package:wall_box_2/logic/models/transaction.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_line/wall_box_line.dart';
import 'package:wall_box_2/logic/services/global.dart';

/// Represents  either a full charging process with a start and an end or an incomplete one (when it got interrupted by an end of the log file)
@freezed
@JsonSerializable()
class WallBoxTransactionBlock {
  /// Represents  either a full charging process with a start and an end or an incomplete one (when it got interrupted by an end of the log file)
  /// - [start] :  stores data of the transactions beginning
  /// - [mvLines] : The interim log lines
  /// - [stop] : stores data of the transactions ending
  WallBoxTransactionBlock({
    this.start,
    required this.mvLines,
    this.stop,
    required this.deviceID,
  });

  static WallBoxTransactionBlock? tryParse(
    String source, {
    String deviceID = 'Unknown device',
  }) {
    print('==============PARSING NEW BLOCK=============');
    MainLine? start;
    MainLine? stop;
    List<MVLine> mvs = List.empty(growable: true);
    final lines = source.split('\n');
    print(lines.length);

    for (final line in lines) {
      print('     ==============PARSING NEW LINE=============');
      print('THIS IS ONE LINE: (($line))');
      if (line.trim().isEmpty) {
        continue;
      }
      final parsedLine = WallboxLine.tryParse(line);
      assert(
        parsedLine != null,
        'Failed Assertion: $parsedLine is not a valid WB line',
      );

      final type = parsedLine!.type;
      print(type);
      switch (type) {
        case LineType.start:
          assert(
            start == null,
            'Failed assertion: Found two start lines in one block. source: \n $source',
          );
          start = parsedLine as MainLine;
          break;
        case LineType.mv:
          assert(
            stop == null,
            'Found stop line after mv line. source: \n $source',
          );
          mvs.add(parsedLine as MVLine);
          break;
        case LineType.stop:
          assert(
            stop == null,
            'Found second stop line. source: \n $source',
          );
          stop = parsedLine as MainLine;
          break;
      }
    }
    // if (mvs.isEmpty) {
    //   print(source);
    //   print('end');
    // }
    return WallBoxTransactionBlock(
      start: start,
      mvLines: mvs,
      deviceID: deviceID,
      stop: stop,
    );
  }

  factory WallBoxTransactionBlock.parse(
    String source, {
    required String deviceID,
  }) => tryParse(source, deviceID: deviceID)!;

  ///stores data of the transactions beginning
  @override
  final MainLine? start;

  /// The interim log lines
  @override
  List<MVLine> mvLines;

  /// stores data of the transactions ending
  @override
  final MainLine? stop;

  @override
  /// the id of the wallbox
  final String deviceID;

  DateTime get firstDate => start?.timeStamp ?? mvLines.first.timeStamp;
  DateTime get lastDate => stop?.timeStamp ?? mvLines.last.timeStamp;

  String get source =>
      '${start != null ? '${start!.source}\n' : ''}${mvLines.fold(
        '',
        (previousValue, element) => previousValue + element.source + '\n',
      )}${stop != null ? '${stop!.source}\n' : ''}';

  @override
  String toString() {
    return 'Start: ${start ?? '/'}\n   num mv: ${mvLines.length},\n   Stop: ${stop ?? '/'}\n';
  }

  /// returns true, if this has a start and an end set
  bool get isCompleted => start != null && stop != null;

  /// the tag ID in this block. Should only be null, if the log file only contained mv lines, wich should be rare (but possible)
  String? get tagID => start?.tagID ?? stop?.tagID;

  /// returns the total power usage as the difference between the start and stop power levels.
  ///
  /// If start or stop is missing, they will be substituted by the accoiding first/ last mv line
  ///
  KiloWattHour get powerUsage {
    return (stop?.powerLevelWh ?? mvLines.last.powerLevelWh) -
        (start?.powerLevelWh ?? mvLines.first.powerLevelWh);
  }

  /// if this is incomplete, we try to find the matching 'other end' of the block to merge with.
  ///
  /// If it is complete or we successfully merged, we create a new WallBoxTransaction
  Future<Transaction?> get tryGetTransaction async {
    WallBoxTransactionBlock block = await IncompleteBlocksRepo().findMergables(
      this,
    );
    return block.isCompleted
        ? Transaction(
            id: generateId(),
            tagID: block.start!.tagID,
            deviceID: deviceID,
            start: block.start!.timeStamp,
            stop: block.stop!.timeStamp,
            usage: block.powerUsage,
          )
        : null;
  }

  bool _canMergeAtStart(WallBoxTransactionBlock other) {
    if (start != null || other.stop != null) return false;
    final ownEnd = mvLines.last;
    final otherEnd = other.mvLines.first;

    return ownEnd.timeStamp.difference(otherEnd.timeStamp).abs() <=
        Duration(minutes: 16);
  }

  bool _canMergeAtEnd(WallBoxTransactionBlock other) {
    if (stop != null || other.start != null) return false;
    final ownEnd = mvLines.first;
    final otherEnd = other.mvLines.last;

    return ownEnd.timeStamp.difference(otherEnd.timeStamp).abs() <=
        Duration(minutes: 16);
  }

  WallBoxTransactionBlock? _tryMerge(WallBoxTransactionBlock other) {
    // if (_canMergeAtStart(other)) {
    //   inCompleteRepo.delete(
    //     other.repoKey,
    //     () async => true,
    //   );
    //   return WallBoxTransactionBlock(
    //     start: other.start,
    //     mvLines: [...other.mvLines, ...mvLines],
    //     stop: stop,
    //   );
    // } else if (_canMergeAtEnd(other)) {
    //   inCompleteRepo.delete(
    //     other.repoKey,
    //     () async => true,
    //   );
    //   return WallBoxTransactionBlock(
    //     start: start,
    //     mvLines: [...mvLines, ...other.mvLines],
    //     stop: other.stop,
    //   );
    // }
    return null;
  }

  /// checks if all WB lines are equal
  bool equals(Object other) =>
      other is WallBoxTransactionBlock &&
      _equalLines(start, other.start) &&
      _equalLines(stop, other.stop) &&
      _equalMVLines(mvLines, other.mvLines);

  static bool _equalLines(MainLine? a, MainLine? b) {
    return a == null && b == null || (a != null && b != null && a.equals(b));
  }

  static bool _equalMVLines(List<MVLine> a, List<MVLine> b) {
    if (a.length != b.length) return false;

    for (int i = 0; i < a.length; i++) {
      if (!a[i].equals(b[i])) return false;
    }
    return true;
  }
}

class TransactionBlockJsonConverter
    extends JsonConverter<WallBoxTransactionBlock, Map<String, Object?>> {
  const TransactionBlockJsonConverter();
  @override
  WallBoxTransactionBlock fromJson(Map<String, Object?> json) =>
      WallBoxTransactionBlock.parse(
        json[IncompleteBlocksColumns.source].toString(),
        deviceID: json[IncompleteBlocksColumns.device_id].toString(),
      );

  @override
  Map<String, String> toJson(WallBoxTransactionBlock object) => {
    IncompleteBlocksColumns.source: object.source,
    IncompleteBlocksColumns.device_id: object.deviceID,
  };
}

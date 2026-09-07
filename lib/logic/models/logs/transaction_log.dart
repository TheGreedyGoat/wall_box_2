import 'package:uuid/uuid.dart';
import 'package:wall_box_2/logic/helpers/units/kilo_watt_hour.dart';
import 'package:wall_box_2/logic/models/logs/log_file.dart';
import 'package:wall_box_2/logic/models/logs/wallbox_log.dart';

RegExp get tagIDRegExp => RegExp(r'kWh ([A-Za-z0-9]+)');
RegExp get timestampRegexp =>
    RegExp(r'(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2}):(\d{2})');
RegExp get powerLevelRegexp => RegExp(r'\d+\.\d+');

/// contains Data from one Transaction block within a log file
class TransactionLog {
  static RegExp get startLineRegexp => RegExp(r'txstart.*');
  static RegExp get stopLineRegexp => RegExp(r'txstop.*');
  static RegExp get mvRegexp => RegExp(r'mv.*');

  /// the db id of [this]
  final String id;

  /// The txstart line
  final StartLine? startLine;

  /// all the mv lines
  final List<MVLine> mvLines;

  /// the txstop line
  final StopLine? stopLine;

  // getters
  /// the tagID
  String get tagId => startLine?.tagID ?? stopLine?.tagID ?? 'unknown';

  /// returns the raw String as it was written in the original file
  String get raw {
    final mv = mvLines.fold(
      '',
      (previousValue, mv) => '$previousValue${mv.raw}\n',
    );

    return '${startLine?.raw ?? ''}\n$mv${stopLine?.raw ?? ''}\n';
  }

  /// contains Data from one Transaction block within a log file
  TransactionLog({
    required this.id,
    required this.startLine,
    required this.mvLines,
    required this.stopLine,
  });

  factory TransactionLog.parseFullBlock(String raw) {
    assert(
      LogFile.fullTransactionRegExp.firstMatch(raw)?.group(0) == raw,
      '$raw is not a valid transaction block!',
    );
    final taLogID = Uuid().v1();
    final rawStart = startLineRegexp.firstMatch(raw)!.group(0)!;
    final rawStop = stopLineRegexp.firstMatch(raw)!.group(0)!;

    final mvLinesRaw = mvRegexp.allMatches(raw);

    return TransactionLog(
      id: taLogID,
      startLine: StartLine.parse(rawStart, taLogID),
      mvLines: mvLinesRaw
          .map(
            (raw) => MVLine.parse(raw.group(0)!, taLogID),
          )
          .toList(),
      stopLine: StopLine.parse(raw, taLogID),
    );
  }
}

/// These lines mark the start of a transaction block.
///
/// Example:
///
/// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh 050FE8E3210000 3 2 N
class StartLine {
  // fields
  /// The line as written in the log file
  final String raw;

  /// the id of the corresponding Transaction Log
  final String taLogID;

  /// the corresponding tagID
  final String tagID;

  /// the corresponding time stamp
  final DateTime timeStamp;

  /// the corresponding power level
  final KiloWattHour powerLevel;

  /// These lines mark the start of a transaction block.
  ///
  /// Example:
  ///
  /// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh 050FE8E3210000 3 2 N
  StartLine({
    required this.raw,
    required this.taLogID,
    required this.tagID,
    required this.timeStamp,
    required this.powerLevel,
  });

  factory StartLine.parse(String raw, String transactionLogID) {
    final timeStampRaw = timestampRegexp.firstMatch(raw)!.group(0)!;
    return StartLine(
      raw: raw,
      taLogID: transactionLogID,
      tagID: tagIDRegExp.firstMatch(raw)?.group(1) ?? 'unknown',
      timeStamp: DateTime.parse(timeStampRaw),
      powerLevel: KiloWattHour(
        wattHours: int.parse(
          powerLevelRegexp.firstMatch(raw)!.group(0)!.replaceAll('.', ''),
        ),
      ),
    );
  }
}

/// These lines mark the stop of a transaction block.
///
/// Example:
///
/// txstop2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh 050FE8E3210000 3 2 N
class StopLine {
  /// The line as written in the log file
  final String raw;

  /// the id of the corresponding Transaction Log
  final String taLogID;

  /// the corresponding tagID
  final String tagID;

  /// the corresponding time stamp
  final DateTime timeStamp;

  /// the corresponding power level
  final KiloWattHour powerLevel;

  /// These lines mark the stop of a transaction block.
  ///
  /// Example:
  ///
  /// txstop2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh 050FE8E3210000 3 2 N
  StopLine({
    required this.raw,
    required this.taLogID,
    required this.tagID,
    required this.timeStamp,
    required this.powerLevel,
  });

  factory StopLine.parse(String raw, String transactionLogID) {
    return StopLine(
      raw: raw,
      taLogID: transactionLogID,
      tagID: tagIDRegExp.firstMatch(raw)?.group(1) ?? 'unknown',
      timeStamp: DateTime.parse(timestampRegexp.firstMatch(raw)!.group(0)!),
      powerLevel: KiloWattHour(
        wattHours: int.parse(
          powerLevelRegexp.firstMatch(raw)!.group(0)!.replaceAll('.', ''),
        ),
      ),
    );
  }
}

/// An intermediate status log during a running transaction
class MVLine {
  /// The line as written in the log file
  final String raw;

  /// the id of the corresponding Transaction Log
  final String taLogID;

  /// parses the time stamp
  final DateTime timeStamp;

  /// parses the power level
  final KiloWattHour powerLevel;

  /// An intermediate status log during a running transaction
  MVLine({
    required this.raw,
    required this.taLogID,
    required this.timeStamp,
    required this.powerLevel,
  });

  factory MVLine.parse(String raw, String transactionLogID) {
    return MVLine(
      raw: raw,
      taLogID: transactionLogID,
      timeStamp: DateTime.parse(timestampRegexp.firstMatch(raw)!.group(0)!),
      powerLevel: KiloWattHour(
        wattHours: int.parse(
          powerLevelRegexp.firstMatch(raw)!.group(0)!.replaceAll('.', ''),
        ),
      ),
    );
  }
}

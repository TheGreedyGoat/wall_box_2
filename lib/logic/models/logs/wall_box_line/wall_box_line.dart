// ignore_for_file: overridden_fields

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/units/kilo_watt_hour.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_log.dart';
part 'wall_box_line.freezed.dart';
part 'wall_box_line.g.dart';

const _startTag = 'txstart';
const _stopTag = 'txstop';
const _mvTag = 'mv';

/// represents the data of a single line within a wallBox log.
///
/// There are 3 types of lines:
///
/// ### start
/// #### example:
/// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh 050FE8E3210000 3 2 N
///
/// ### stop
/// #### example:
/// txstop2: id 0xffffffffffffffff, socket 1, 2026-01-24 14:43:49 2593.341kWh 050FE8E3210000 6 5 N
///
/// ### mv
/// #### example:
/// mv: socket 1, 2026-01-24 07:40:58 2593.341 N
///
/// because start and stop both have the same pattern use the [MainLine] subclass, mv lines are converted to [MVLine] instances

abstract class WallboxLine {
  /// The date parsed from the source:
  ///
  /// txstart2: id 0xffffffffffffffff, socket 1, ===>2026-01-24 07:40:58<=== 2593.341kWh 050FE8E3210000 3 2 N
  ///
  /// mv: socket 1, ===>2026-01-24 07:40:58<=== 2593.341 N
  ///
  late final DateTime timeStamp;

  /// The power usage level parsed from the source:
  ///
  /// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 ===>2593.341<===kWh 050FE8E3210000 3 2 N
  ///
  /// mv: socket 1, 2026-01-24 07:40:58 ===>2593.341<=== N
  late final KiloWattHour powerLevelWh;

  /// txstart, txstop or mv
  LineType get type;

  /// Extracts relevant data if [source] is a valid line
  static WallboxLine? tryParse(String source) {
    bool isMV = source.startsWith(_mvTag);
    bool isStart = !isMV && source.startsWith(_startTag);
    bool isStop = !isMV && !isStart && source.startsWith(_stopTag);

    if (!isMV && !isStart && !isStop) return null;

    final timeStampMatch = RegExp(
      DataType.date.regExSource,
    ).stringMatch(source);
    final DateTime? timeStamp = DateTime.tryParse(timeStampMatch.toString());

    if (timeStamp == null) {
      return null;
    }
    final powerUsageMatch = RegExp(
      DataType.power.regExSource,
    ).stringMatch(source);

    final double? pU = double.tryParse(
      powerUsageMatch.toString(),
    );
    final int? powerUsage = pU != null ? (pU * 1000).floor() : null;

    if (powerUsage == null) {
      return null;
    }
    // assert(
    //   powerUsage != null,
    //   'Line $source does not contain a value for power usage',
    // );

    if (isMV) {
      return MVLine(timeStamp, KiloWattHour(wattHours: powerUsage));
    } else if (isStart || isStop) {
      final tagIDMatch = RegExp(DataType.tagID.regExSource).stringMatch(source);
      if (tagIDMatch == null) {
        return null;
      }
      return MainLine(
        timeStamp,
        KiloWattHour(wattHours: powerUsage),
        tagIDMatch,
        isStart,
      );
    }
    return null;
  }

  @override
  String toString() =>
      'Type: $type, TimeStamp: $timeStamp, Usage: $powerLevelWh';

  /// Declared by implementing classes
  bool equals(Object other);

  /// returns true, if both lines have the same type, timestamp and powerLevel
  static bool equality(WallboxLine a, WallboxLine b) {
    return a.type == b.type &&
        a.powerLevelWh == b.powerLevelWh &&
        a.timeStamp == b.timeStamp;
  }
}

// 88b           d88              88
// 888b         d888              ""
// 88`8b       d8'88
// 88 `8b     d8' 88  ,adPPYYba,  88  8b,dPPYba,
// 88  `8b   d8'  88  ""     `Y8  88  88P'   `"8a
// 88   `8b d8'   88  ,adPPPPP88  88  88       88
// 88    `888'    88  88,    ,88  88  88       88
// 88     `8'     88  `"8bbdP"Y8  88  88       88

@freezed
@JsonSerializable(converters: [KiloWattHourConverter()])
/// The start &  stop lines in the log. Every complete Transaction starts and aends with a [MainLine]
///
///
/// ### start
/// #### example:
/// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh 050FE8E3210000 3 2 N
///
/// ### stop
/// #### example:
/// txstop2: id 0xffffffffffffffff, socket 1, 2026-01-24 14:43:49 2593.341kWh 050FE8E3210000 6 5 N
class MainLine extends WallboxLine with _$MainLine {
  /// The start &  stop lines in the log. Every complete Transaction starts and aends with a [MainLine]
  ///
  ///
  /// ### start
  /// #### example:
  /// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh 050FE8E3210000 3 2 N
  ///
  /// ### stop
  /// #### example:
  /// txstop2: id 0xffffffffffffffff, socket 1, 2026-01-24 14:43:49 2593.341kWh 050FE8E3210000 6 5 N
  MainLine(
    this.timeStamp,
    @KiloWattHourConverter() @JsonKey(name: 'powerLevel') this.powerLevelWh,
    this.tagID,
    this.isStart,
  );

  /// The power usage level parsed from the source:
  ///
  /// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 ===>2593.341<===kWh 050FE8E3210000 3 2 N
  @override
  final KiloWattHour powerLevelWh;

  @override
  /// The date parsed from the source:
  ///
  /// txstart2: id 0xffffffffffffffff, socket 1, ===>2026-01-24 07:40:58<=== 2593.341kWh 050FE8E3210000 3 2 N
  final DateTime timeStamp;
  @override
  /// The tag-ID parsed from the source:
  ///
  /// txstart2: id 0xffffffffffffffff, socket 1, 2026-01-24 07:40:58 2593.341kWh ===>050FE8E3210000<=== 3 2 N
  final String tagID;
  @override
  /// tells if this is the start or the end of a Transaction
  final bool isStart;

  @override
  LineType get type => isStart ? LineType.start : LineType.stop;
  @override
  String toString() {
    return '${super.toString()}, $tagID';
  }

  /// conversion to a json map
  factory MainLine.fromJson(Map<String, Object?> json) =>
      _$MainLineFromJson(json);

  /// creation from a json map
  Map<String, Object?> toJson() => _$MainLineToJson(this);

  @override
  bool equals(Object other) =>
      other is MainLine &&
      WallboxLine.equality(this, other) &&
      isStart == other.isStart &&
      tagID == other.tagID;
}

// 88b           d88  8b           d8
// 888b         d888  `8b         d8'
// 88`8b       d8'88   `8b       d8'
// 88 `8b     d8' 88    `8b     d8'
// 88  `8b   d8'  88     `8b   d8'
// 88   `8b d8'   88      `8b d8'
// 88    `888'    88       `888'
// 88     `8'     88        `8'

/// Represents an 'mv'- line: Log lines in between a start and stop that show an interim status.
///
/// Only needed for block merging
///
/// ### mv
/// #### example:
/// mv: socket 1, 2026-01-24 07:40:58 2593.341 N
@freezed
@JsonSerializable(converters: [KiloWattHourConverter()])
class MVLine extends WallboxLine with _$MVLine {
  @override
  LineType get type => LineType.mv;

  /// Represents an 'mv'- line: Log lines in between a start and stop that show an interim status.
  ///
  /// Only needed for block merging
  ///
  /// ### mv
  /// #### example:
  /// mv: socket 1, 2026-01-24 07:40:58 2593.341 N
  MVLine(
    this.timeStamp,
    @KiloWattHourConverter() @JsonKey(name: 'powerLevel') this.powerLevelWh,
  );
  @override
  late final KiloWattHour powerLevelWh;

  @override
  late final DateTime timeStamp;

  ///
  factory MVLine.fromJson(Map<String, Object?> json) => _$MVLineFromJson(json);

  ///
  Map<String, Object?> toJson() => _$MVLineToJson(this);

  @override
  bool equals(Object other) =>
      other is MVLine && WallboxLine.equality(this, other);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/helpers/units/kilo_watt_hour.dart';

part 'wall_box_transaction.freezed.dart';
part 'wall_box_transaction.g.dart';

@freezed
@JsonSerializable(converters: [KiloWattHourConverter()])
/// Describes one transaction at a wallbox
class WallBoxTransaction with _$WallBoxTransaction {
  @override
  /// unique key for this transaction
  final String id;

  @override
  /// the id of the tag used for the transaction
  final String tagID;

  @override
  /// The Wallbox Device ID
  final String wallboxID;

  @override
  /// The start time of the transaction
  final DateTime start;

  @override
  /// The stop time of the transaction
  final DateTime stop;

  @override
  /// How much power was consumed?
  final KiloWattHour usage;

  /// Returns the [Interval] when this Transaction took place
  Interval get interval => Interval(from: start, to: stop);

  /// Describes one transaction at a wallbox
  const WallBoxTransaction({
    required this.id,
    required this.tagID,
    required this.wallboxID,
    required this.start,
    required this.stop,
    @KiloWattHourConverter() @JsonKey(name: 'usage') required this.usage,
  });
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/helpers/units/kilo_watt_hour.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
@JsonSerializable(converters: [KiloWattHourConverter()])
/// Describes one transaction at a wallbox
class Transaction with _$Transaction {
  @override
  /// unique key for this transaction
  final String id;

  @override
  /// the id of the tag used for the transaction
  final String tagID;

  @override
  /// The Wallbox Device ID
  final String deviceID;

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
  const Transaction({
    required this.id,
    required this.tagID,
    required this.deviceID,
    required this.start,
    required this.stop,
    @KiloWattHourConverter() @JsonKey(name: 'usage') required this.usage,
  });
}

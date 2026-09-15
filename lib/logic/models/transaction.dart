import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/transaction_table.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/helpers/percent.dart';
import 'package:wall_box_2/logic/helpers/units/kilo_watt_hour.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

@freezed
@JsonSerializable(
  converters: [
    KiloWattHourConverter(),
    PercentJSONConverter(),
    TagAssignmentJsonConverterNullable(),
  ],
)
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

  @override
  /// An optional discount to give on this particular transaction. Will be reduced from the base price
  final Percent? discount;

  // Euro? get basePrice => tagAssignment?.customer.;

  /// Returns the [Interval] when this Transaction took place
  Interval get interval => Interval(from: start, to: stop);

  /// Describes one transaction at a wallbox
  const Transaction({
    @JsonKey(name: TransactionColumns.id) required this.id,
    @JsonKey(name: TransactionColumns.tag_id) required this.tagID,
    @JsonKey(name: TransactionColumns.device_id) required this.deviceID,
    @JsonKey(name: TransactionColumns.start) required this.start,
    @JsonKey(name: TransactionColumns.stop) required this.stop,
    @PercentJSONConverter()
    @JsonKey(name: TransactionColumns.discount)
    this.discount,
    @KiloWattHourConverter()
    @JsonKey(name: TransactionColumns.power_usage)
    required this.usage,
  });
}

class TransactionJsonConverter
    extends JsonConverter<Transaction, Map<String, Object?>> {
  const TransactionJsonConverter();

  @override
  Transaction fromJson(Map<String, Object?> json) =>
      _$TransactionFromJson(json);

  @override
  Map<String, Object?> toJson(Transaction object) =>
      _$TransactionToJson(object);
}

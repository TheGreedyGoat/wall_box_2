import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/price_assignment_table.dart';
import 'package:wall_box_2/logic/helpers/units/euro.dart';
import 'package:wall_box_2/logic/models/assignments/assignment.dart';

part 'price_assignment.freezed.dart';
part 'price_assignment.g.dart';

@freezed
@JsonSerializable(
  createJsonSchema: true,
  converters: [
    EuroJsonConverter(),
  ],
)
class PriceAssignment extends Assignment with _$PriceAssignment {
  @override
  final DateTime from;
  @override
  final DateTime? to;

  final String customerID;
  final Euro price;

  const PriceAssignment({
    @JsonKey(name: PriceAssignmentColumns.customer_id) required this.customerID,
    @EuroJsonConverter()
    @JsonKey(name: PriceAssignmentColumns.price)
    required this.price,
    @JsonKey(name: PriceAssignmentColumns.from) required this.from,
    @JsonKey(name: PriceAssignmentColumns.to) this.to,
  });
}

class PriceAssignmentJsonConverter
    extends JsonConverter<PriceAssignment, Map<String, Object?>> {
  const PriceAssignmentJsonConverter();

  @override
  PriceAssignment fromJson(Map<String, Object?> json) =>
      _$PriceAssignmentFromJson(json);

  @override
  Map<String, Object?> toJson(PriceAssignment object) =>
      _$PriceAssignmentToJson(object);
}

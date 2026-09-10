import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/models/assignments/assignment.dart';
import 'package:wall_box_2/logic/models/assignments/price_assignment.dart';
import 'package:wall_box_2/logic/models/master_data/customer.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

part 'tag_assignment.freezed.dart';
part 'tag_assignment.g.dart';

@freezed
@JsonSerializable(converters: [CustomerJsonConverter()])
class TagAssignment extends Assignment with _$TagAssignment {
  @override
  final DateTime from;
  @override
  final DateTime? to;

  final String tagID;
  final String? tagName;

  final Customer customer;

  Interval get interval => Interval(
    from: from,
    to: to ?? DateTime.now(),
  );
  const TagAssignment({
    required this.tagID,
    @CustomerJsonConverter() required this.customer,
    this.tagName,
    required this.from,
    this.to,
  }) : super(from: from, to: to);

  bool matchTransaction(Transaction ta) =>
      ta.tagID == tagID && interval.containsDate(ta.start);

  bool overlapsPriceAssignment(PriceAssignment pa) =>
      pa.customer.id == this.customer.id &&
      pa.interval.intersects(this.interval);
}

class TagAssignmentJsonConverter
    extends JsonConverter<TagAssignment, Map<String, dynamic>> {
  const TagAssignmentJsonConverter();
  @override
  TagAssignment fromJson(Map<String, dynamic> json) =>
      _$TagAssignmentFromJson(json);

  @override
  Map<String, dynamic> toJson(TagAssignment object) =>
      _$TagAssignmentToJson(object);
}

class TagAssignmentJsonConverterNullable
    extends JsonConverter<TagAssignment?, Map<String, dynamic>?> {
  const TagAssignmentJsonConverterNullable();
  @override
  TagAssignment? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$TagAssignmentFromJson(json);

  @override
  Map<String, dynamic>? toJson(TagAssignment? object) =>
      object == null ? null : _$TagAssignmentToJson(object);
}

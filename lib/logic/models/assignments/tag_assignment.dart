import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/tag_assignment_table.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/models/assignments/assignment.dart';

part 'tag_assignment.freezed.dart';
part 'tag_assignment.g.dart';

@freezed
@JsonSerializable(createJsonSchema: true)
class TagAssignment extends Assignment with _$TagAssignment {
  @override
  final DateTime from;
  @override
  final DateTime? to;

  @override
  final String tagID;

  @override
  final String customerID;

  @override
  Interval get interval => Interval(
    from: from,
    to: to ?? DateTime.now(),
  );
  const TagAssignment({
    @JsonKey(name: TagAssignmentColumns.tag_id) required this.tagID,
    @JsonKey(name: TagAssignmentColumns.customer_id) required this.customerID,
    @JsonKey(name: TagAssignmentColumns.from) required this.from,
    @JsonKey(name: TagAssignmentColumns.to) this.to,
  });

  @override
  List<DataError?> get validationList => throw UnimplementedError();
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

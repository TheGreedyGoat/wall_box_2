import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/tag_assignment_table.dart';
import 'package:wall_box_2/logic/models/assignments/assignment.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

part 'tag_assignment.freezed.dart';
part 'tag_assignment.g.dart';

@freezed
@JsonSerializable(createJsonSchema: true)
/// Model class to depict wich customer a tag is assigned to and in wich period of time.
///
/// One customer can have multiple tags assigned at a given time, but one tag should never be assigned to more than 1 customer at a time
class TagAssignment extends Assignment with _$TagAssignment {
  @override
  final DateTime from;
  @override
  final DateTime? to;

  @override
  /// The assigned tag's id
  final String tagID;

  @override
  /// the id of the customer the tag is assigned to
  final String customerID;

  /// Model class to depict wich customer a tag is assigned to and in wich period of time.
  ///
  /// One customer can have multiple tags assigned at a given time, but one tag should never be assigned to more than 1 customer at a time
  const TagAssignment({
    @JsonKey(name: TagAssignmentColumns.tag_id) required this.tagID,
    @JsonKey(name: TagAssignmentColumns.customer_id) required this.customerID,
    @JsonKey(name: TagAssignmentColumns.from) required this.from,
    @JsonKey(name: TagAssignmentColumns.to) this.to,
  });

  bool matchTransaction(Transaction transaction) {
    return tagID == transaction.tagID &&
        interval.containsDate(transaction.start);
  }
}

/// used to convert a [TagAssignment] to a json object.
///
/// This format is used by the database
class TagAssignmentJsonConverter
    extends JsonConverter<TagAssignment, Map<String, Object?>> {
  /// used to convert a [TagAssignment] to a json object.
  ///
  /// This format is used by the database
  const TagAssignmentJsonConverter();
  @override
  TagAssignment fromJson(Map<String, Object?> json) =>
      _$TagAssignmentFromJson(json);

  @override
  Map<String, Object?> toJson(TagAssignment object) =>
      _$TagAssignmentToJson(object);
}

/// a nullable version of the converter
class TagAssignmentJsonConverterNullable
    extends JsonConverter<TagAssignment?, Map<String, dynamic>?> {
  /// a nullable version of the converter
  const TagAssignmentJsonConverterNullable();
  @override
  TagAssignment? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$TagAssignmentFromJson(json);

  @override
  Map<String, dynamic>? toJson(TagAssignment? object) =>
      object == null ? null : _$TagAssignmentToJson(object);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagAssignment _$TagAssignmentFromJson(Map<String, dynamic> json) =>
    TagAssignment(
      tagID: json['tag_id'] as String,
      customerID: json['customer_id'] as String,
      from: DateTime.parse(json['starts_at'] as String),
      to: json['ends_at'] == null
          ? null
          : DateTime.parse(json['ends_at'] as String),
    );

Map<String, dynamic> _$TagAssignmentToJson(TagAssignment instance) =>
    <String, dynamic>{
      'starts_at': instance.from.toIso8601String(),
      'ends_at': instance.to?.toIso8601String(),
      'tag_id': instance.tagID,
      'customer_id': instance.customerID,
    };

const _$TagAssignmentJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'starts_at': {'type': 'string', 'format': 'date-time'},
    'ends_at': {'type': 'string', 'format': 'date-time'},
    'tag_id': {'type': 'string'},
    'customer_id': {'type': 'string'},
  },
  'required': ['starts_at', 'tag_id', 'customer_id'],
};

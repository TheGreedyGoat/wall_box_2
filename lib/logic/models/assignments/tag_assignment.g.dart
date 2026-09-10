// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tag_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagAssignment _$TagAssignmentFromJson(Map<String, dynamic> json) =>
    TagAssignment(
      tagID: json['tagID'] as String,
      customer: const CustomerJsonConverter().fromJson(
        json['customer'] as Map<String, dynamic>,
      ),
      tagName: json['tagName'] as String?,
      from: DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    );

Map<String, dynamic> _$TagAssignmentToJson(TagAssignment instance) =>
    <String, dynamic>{
      'from': instance.from.toIso8601String(),
      'to': instance.to?.toIso8601String(),
      'tagID': instance.tagID,
      'tagName': instance.tagName,
      'customer': const CustomerJsonConverter().toJson(instance.customer),
    };

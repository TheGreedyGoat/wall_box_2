// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_assignment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceAssignment _$PriceAssignmentFromJson(Map<String, dynamic> json) =>
    PriceAssignment(
      customerID: json['customer_id'] as String,
      price: const EuroJsonConverter().fromJson((json['price'] as num).toInt()),
      from: DateTime.parse(json['starts_at'] as String),
      to: json['ends_at'] == null
          ? null
          : DateTime.parse(json['ends_at'] as String),
    );

Map<String, dynamic> _$PriceAssignmentToJson(PriceAssignment instance) =>
    <String, dynamic>{
      'starts_at': instance.from.toIso8601String(),
      'ends_at': instance.to?.toIso8601String(),
      'customer_id': instance.customerID,
      'price': const EuroJsonConverter().toJson(instance.price),
    };

const _$PriceAssignmentJsonSchema = {
  r'$schema': 'https://json-schema.org/draft/2020-12/schema',
  'type': 'object',
  'properties': {
    'starts_at': {'type': 'string', 'format': 'date-time'},
    'ends_at': {'type': 'string', 'format': 'date-time'},
    'customer_id': {'type': 'string'},
    'price': {r'$ref': r'#/$defs/Euro'},
  },
  'required': ['starts_at', 'customer_id', 'price'],
  r'$defs': {
    'Euro': {
      'type': 'object',
      'properties': {
        'value': {'type': 'integer'},
      },
      'required': ['value'],
    },
  },
};

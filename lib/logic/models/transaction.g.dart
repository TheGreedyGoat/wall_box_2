// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String,
  tagID: json['tag_id'] as String,
  deviceID: json['device_id'] as String,
  start: DateTime.parse(json['start'] as String),
  stop: DateTime.parse(json['stop'] as String),
  discount: _$JsonConverterFromJson<int, Percent>(
    json['discount'],
    const PercentJSONConverter().fromJson,
  ),
  usage: const KiloWattHourConverter().fromJson(
    (json['power_usage'] as num).toInt(),
  ),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tag_id': instance.tagID,
      'device_id': instance.deviceID,
      'start': instance.start.toIso8601String(),
      'stop': instance.stop.toIso8601String(),
      'power_usage': const KiloWattHourConverter().toJson(instance.usage),
      'discount': _$JsonConverterToJson<int, Percent>(
        instance.discount,
        const PercentJSONConverter().toJson,
      ),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

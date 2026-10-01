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
  status: $enumDecode(_$BillingStatusEnumMap, json['billing_status']),
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
      'billing_status': _$BillingStatusEnumMap[instance.status]!,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) => json == null ? null : fromJson(json as Json);

const _$BillingStatusEnumMap = {
  BillingStatus.open: 'open',
  BillingStatus.billed: 'billed',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);

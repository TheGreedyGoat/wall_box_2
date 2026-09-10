// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String,
  tagID: json['tagID'] as String,
  deviceID: json['deviceID'] as String,
  start: DateTime.parse(json['start'] as String),
  stop: DateTime.parse(json['stop'] as String),
  usage: const KiloWattHourConverter().fromJson((json['usage'] as num).toInt()),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagID': instance.tagID,
      'deviceID': instance.deviceID,
      'start': instance.start.toIso8601String(),
      'stop': instance.stop.toIso8601String(),
      'usage': const KiloWattHourConverter().toJson(instance.usage),
    };

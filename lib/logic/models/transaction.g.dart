// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: json['id'] as String,
  tagID: json['tagID'] as String,
  wallboxID: json['wallboxID'] as String,
  start: DateTime.parse(json['from'] as String),
  stop: DateTime.parse(json['to'] as String),
  usage: const KiloWattHourConverter().fromJson((json['usage'] as num).toInt()),
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagID': instance.tagID,
      'wallboxID': instance.wallboxID,
      'from': instance.start.toIso8601String(),
      'to': instance.stop.toIso8601String(),
      'usage': const KiloWattHourConverter().toJson(instance.usage),
    };

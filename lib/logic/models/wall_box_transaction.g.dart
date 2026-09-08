// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wall_box_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallBoxTransaction _$WallBoxTransactionFromJson(Map<String, dynamic> json) =>
    WallBoxTransaction(
      id: json['id'] as String,
      tagID: json['tagID'] as String,
      wallboxID: json['wallboxID'] as String,
      start: DateTime.parse(json['start'] as String),
      stop: DateTime.parse(json['stop'] as String),
      usage: const KiloWattHourConverter().fromJson(
        (json['usage'] as num).toInt(),
      ),
    );

Map<String, dynamic> _$WallBoxTransactionToJson(WallBoxTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tagID': instance.tagID,
      'wallboxID': instance.wallboxID,
      'start': instance.start.toIso8601String(),
      'stop': instance.stop.toIso8601String(),
      'usage': const KiloWattHourConverter().toJson(instance.usage),
    };

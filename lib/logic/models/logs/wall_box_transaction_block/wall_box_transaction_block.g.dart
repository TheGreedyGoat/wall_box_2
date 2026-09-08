// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wall_box_transaction_block.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WallBoxTransactionBlock _$WallBoxTransactionBlockFromJson(
  Map<String, dynamic> json,
) => WallBoxTransactionBlock(
  start: json['start'] == null
      ? null
      : MainLine.fromJson(json['start'] as Map<String, dynamic>),
  mvLines: (json['mvLines'] as List<dynamic>)
      .map((e) => MVLine.fromJson(e as Map<String, dynamic>))
      .toList(),
  stop: json['stop'] == null
      ? null
      : MainLine.fromJson(json['stop'] as Map<String, dynamic>),
  deviceID: json['deviceID'] as String,
);

Map<String, dynamic> _$WallBoxTransactionBlockToJson(
  WallBoxTransactionBlock instance,
) => <String, dynamic>{
  'start': instance.start,
  'mvLines': instance.mvLines,
  'stop': instance.stop,
  'deviceID': instance.deviceID,
};

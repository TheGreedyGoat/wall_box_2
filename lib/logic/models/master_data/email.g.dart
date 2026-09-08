// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
  id: json['id'] as String,
  firstPart: json['firstPart'] as String?,
  secondPart: json['secondPart'] as String?,
  domain: json['domain'] as String?,
);

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
  'id': instance.id,
  'firstPart': instance.firstPart,
  'secondPart': instance.secondPart,
  'domain': instance.domain,
};

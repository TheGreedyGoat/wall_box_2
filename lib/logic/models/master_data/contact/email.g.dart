// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'email.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Email _$EmailFromJson(Map<String, dynamic> json) => Email(
  local: json['local'] as String?,
  subdomain: json['subdomain'] as String?,
  topLevelDomain: json['topLevelDomain'] as String?,
);

Map<String, dynamic> _$EmailToJson(Email instance) => <String, dynamic>{
  'local': instance.local,
  'subdomain': instance.subdomain,
  'topLevelDomain': instance.topLevelDomain,
};

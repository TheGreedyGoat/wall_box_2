// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  id: json['id'] as String,
  street: json['street'] as String?,
  postcode: json['postcode'] as String?,
  number: json['number'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String?,
  adressAdditions: json['adressAdditions'] as String?,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'id': instance.id,
  'street': instance.street,
  'number': instance.number,
  'postcode': instance.postcode,
  'city': instance.city,
  'country': instance.country,
  'adressAdditions': instance.adressAdditions,
};

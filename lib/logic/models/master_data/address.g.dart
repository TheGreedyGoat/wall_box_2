// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
  customerID: json['customer_id'] as String,
  street: json['street'] as String?,
  number: json['house_number'] as String?,
  postcode: json['postcode'] as String?,
  city: json['city'] as String?,
  state: json['state'] as String?,
  country: json['country'] as String?,
  adressAdditions: json['adress_additions'] as String?,
);

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
  'customer_id': instance.customerID,
  'street': instance.street,
  'house_number': instance.number,
  'postcode': instance.postcode,
  'city': instance.city,
  'state': instance.state,
  'country': instance.country,
  'adress_additions': instance.adressAdditions,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
  id: json['id'] as String,
  address: const AddressJsonConverter().fromJson(
    json['address'] as Map<String, dynamic>,
  ),
  contact: const ContactDataJsonConverter().fromJson(
    json['contact'] as Map<String, dynamic>,
  ),
  personal: const PersonalDataJsonConverterNullable().fromJson(
    json['personal'] as Map<String, dynamic>?,
  ),
  company: const CompanyDataJsonConverterNullable().fromJson(
    json['company'] as Map<String, dynamic>?,
  ),
);

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
  'id': instance.id,
  'company': const CompanyDataJsonConverterNullable().toJson(instance.company),
  'personal': const PersonalDataJsonConverterNullable().toJson(
    instance.personal,
  ),
  'address': const AddressJsonConverter().toJson(instance.address),
  'contact': const ContactDataJsonConverter().toJson(instance.contact),
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyData _$CompanyDataFromJson(Map<String, dynamic> json) => CompanyData(
  id: json['id'] as String,
  companyName: json['companyName'] as String?,
  address: const AddressJsonConverter().fromJson(
    json['address'] as Map<String, dynamic>?,
  ),
  contact: const ContactDataJsonConverter().fromJson(
    json['contact'] as Map<String, dynamic>?,
  ),
);

Map<String, dynamic> _$CompanyDataToJson(CompanyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'address': const AddressJsonConverter().toJson(instance.address),
      'contact': const ContactDataJsonConverter().toJson(instance.contact),
    };

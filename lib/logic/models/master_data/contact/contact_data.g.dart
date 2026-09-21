// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactData _$ContactDataFromJson(Map<String, dynamic> json) => ContactData(
  customerID: json['customer_id'] as String,
  phone: const PhoneJsonConverter().fromJson(json['phone'] as String?),
  mobile: const PhoneJsonConverter().fromJson(json['mobile'] as String?),
  fax: const PhoneJsonConverter().fromJson(json['fax'] as String?),
  email: const EmailJsonConverter().fromJson(json['email'] as String?),
  website: json['website'] as String?,
);

Map<String, dynamic> _$ContactDataToJson(ContactData instance) =>
    <String, dynamic>{
      'customer_id': instance.customerID,
      'phone': const PhoneJsonConverter().toJson(instance.phone),
      'mobile': const PhoneJsonConverter().toJson(instance.mobile),
      'fax': const PhoneJsonConverter().toJson(instance.fax),
      'email': const EmailJsonConverter().toJson(instance.email),
      'website': instance.website,
    };

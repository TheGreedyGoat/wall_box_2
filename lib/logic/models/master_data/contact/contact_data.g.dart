// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactData _$ContactDataFromJson(Map<String, dynamic> json) => ContactData(
  id: json['id'] as String,
  phone: const PhoneJsonConverter().fromJson(json['phone'] as String?),
  mobile: const PhoneJsonConverter().fromJson(json['mobile'] as String?),
  email: const EmailJsonConverter().fromJson(json['email'] as String?),
);

Map<String, dynamic> _$ContactDataToJson(ContactData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': const PhoneJsonConverter().toJson(instance.phone),
      'mobile': const PhoneJsonConverter().toJson(instance.mobile),
      'email': const EmailJsonConverter().toJson(instance.email),
    };

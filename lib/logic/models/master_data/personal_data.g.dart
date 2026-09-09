// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalData _$PersonalDataFromJson(Map<String, dynamic> json) => PersonalData(
  id: json['id'] as String,
  prename: json['prename'] as String?,
  surname: json['surname'] as String?,
  contact: const ContactDataJsonConverter().fromJson(
    json['contact'] as Map<String, dynamic>?,
  ),
  address: const AddressJsonConverter().fromJson(
    json['address'] as Map<String, dynamic>?,
  ),
);

Map<String, dynamic> _$PersonalDataToJson(PersonalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prename': instance.prename,
      'surname': instance.surname,
      'contact': const ContactDataJsonConverter().toJson(instance.contact),
      'address': const AddressJsonConverter().toJson(instance.address),
    };

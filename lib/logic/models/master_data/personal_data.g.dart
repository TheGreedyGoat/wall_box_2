// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalData _$PersonalDataFromJson(Map<String, dynamic> json) => PersonalData(
  customerID: json['customer_id'] as String,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  title: json['title'] as String?,
  prename: json['prename'] as String?,
  surname: json['surname'] as String?,
);

Map<String, dynamic> _$PersonalDataToJson(PersonalData instance) =>
    <String, dynamic>{
      'customer_id': instance.customerID,
      'gender': _$GenderEnumMap[instance.gender],
      'title': instance.title,
      'prename': instance.prename,
      'surname': instance.surname,
    };

const _$GenderEnumMap = {
  Gender.male: null,
  Gender.female: null,
  Gender.divers: null,
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonalData _$PersonalDataFromJson(Map<String, dynamic> json) => PersonalData(
  id: json['id'] as String,
  gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
  prename: json['prename'] as String?,
  surname: json['surname'] as String?,
);

Map<String, dynamic> _$PersonalDataToJson(PersonalData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'gender': _$GenderEnumMap[instance.gender],
      'prename': instance.prename,
      'surname': instance.surname,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
  Gender.divers: 'divers',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyData _$CompanyDataFromJson(Map<String, dynamic> json) => CompanyData(
  id: json['id'] as String,
  companyName: json['companyName'] as String?,
  companyAddition: json['companyAddition'] as String?,
);

Map<String, dynamic> _$CompanyDataToJson(CompanyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'companyName': instance.companyName,
      'companyAddition': instance.companyAddition,
    };

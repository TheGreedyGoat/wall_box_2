// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyData _$CompanyDataFromJson(Map<String, dynamic> json) => CompanyData(
  customerID: json['customer_id'] as String,
  companyName: json['company_name'] as String?,
  companyAddition: json['company_addition'] as String?,
);

Map<String, dynamic> _$CompanyDataToJson(CompanyData instance) =>
    <String, dynamic>{
      'customer_id': instance.customerID,
      'company_name': instance.companyName,
      'company_addition': instance.companyAddition,
    };

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'company_data.freezed.dart';
part 'company_data.g.dart';

@freezed
@JsonSerializable()
/// represents data for a company
///
/// All fields are required for validation
class CompanyData extends MasterData with _$CompanyData {
  @override
  final String id;
  @override
  final String? companyName;
  final String? companyAddition;

  /// represents data for a company
  ///
  /// All fields are required for validation
  CompanyData({
    required this.id,
    required this.companyName,
    this.companyAddition,
  });

  @override
  List<DataError?> get validationList => [
    (companyName ?? '').isEmpty ? DataError.noCompanyName : null,
  ];
}

class CompanyDataJsonConverter
    extends JsonConverter<CompanyData, Map<String, dynamic>> {
  const CompanyDataJsonConverter();
  @override
  CompanyData fromJson(Map<String, dynamic> json) =>
      _$CompanyDataFromJson(json);

  @override
  Map<String, dynamic> toJson(CompanyData object) =>
      _$CompanyDataToJson(object);
}

class CompanyDataJsonConverterNullable
    extends JsonConverter<CompanyData?, Map<String, dynamic>?> {
  const CompanyDataJsonConverterNullable();
  @override
  CompanyData? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$CompanyDataFromJson(json);

  @override
  Map<String, dynamic>? toJson(CompanyData? object) =>
      object == null ? null : _$CompanyDataToJson(object);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/personal_table.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/helpers/enums/genders.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'personal_data.freezed.dart';
part 'personal_data.g.dart';

@freezed
@JsonSerializable()
/// contains data about a natural person.
/// All fields are required.
///
class PersonalData extends MasterData with _$PersonalData {
  @override
  final String customerID;

  /// m, w, d
  @override
  final Gender? gender;
  @override
  final String? title;
  @override
  final String? prename;
  @override
  final String? surname;

  /// contains data about a natural person.
  /// All fields are required.
  PersonalData({
    @JsonKey(name: PersonalColumns.customer_id) required this.customerID,
    @JsonKey(name: PersonalColumns.gender) this.gender,
    @JsonKey(name: PersonalColumns.title) this.title,
    @JsonKey(name: PersonalColumns.prename) this.prename,
    @JsonKey(name: PersonalColumns.surname) this.surname,
  });

  @override
  List<DataError?> get validationList => [
    (surname ?? '').isEmpty ? DataError.noSurname : null,
  ];
}

///
class PersonalDataJsonConverter
    extends JsonConverter<PersonalData, Map<String, dynamic>> {
  ///
  const PersonalDataJsonConverter();
  @override
  PersonalData fromJson(Map<String, dynamic> json) =>
      _$PersonalDataFromJson(json);

  @override
  Map<String, dynamic> toJson(PersonalData object) =>
      _$PersonalDataToJson(object);
}

///
class PersonalDataJsonConverterNullable
    extends JsonConverter<PersonalData?, Map<String, dynamic>?> {
  ///
  const PersonalDataJsonConverterNullable();
  @override
  PersonalData? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$PersonalDataFromJson(json);

  @override
  Map<String, dynamic>? toJson(PersonalData? object) =>
      object == null ? null : _$PersonalDataToJson(object);
}

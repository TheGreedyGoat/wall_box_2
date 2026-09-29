import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/contact_table.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/contact/email.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/phone.dart';

part 'contact_data.freezed.dart';
part 'contact_data.g.dart';

@freezed
@JsonSerializable(
  converters: [
    PhoneJsonConverter(),
    EmailJsonConverter(),
  ],
)
/// contains contact data such as phone numbers and an email address
class ContactData extends MasterData with _$ContactData {
  @override
  final String customerID;
  @override
  final Phone? phone;
  @override
  final Phone? mobile;
  @override
  final Phone? fax;
  @override
  final Email? email;

  @override
  final String? website;

  /// contains contact data such as phone numbers and an email address
  const ContactData({
    @JsonKey(name: ContactColumns.customer_id) required this.customerID,
    @JsonKey(name: ContactColumns.phone) @PhoneJsonConverter() this.phone,
    @JsonKey(name: ContactColumns.mobile) @PhoneJsonConverter() this.mobile,
    @JsonKey(name: ContactColumns.fax) @PhoneJsonConverter() this.fax,
    @JsonKey(name: ContactColumns.email) @EmailJsonConverter() this.email,
    @JsonKey(name: ContactColumns.website) this.website,
  });

  @override
  get validationList {
    return [
      if (mobile != null)
        ...mobile!.validate().map(
          (error) => error == DataError.invalidPhoneNumber
              ? DataError.invalidMobile
              : error,
        ),
      if (phone != null)
        ...phone!.validate().map(
          (error) => error == DataError.invalidPhoneNumber
              ? DataError.invalidPhone
              : error,
        ),
      if (fax != null)
        ...fax!.validate().map(
          (error) => error == DataError.invalidPhoneNumber
              ? DataError.invalidFax
              : error,
        ),
      if (email != null) ...email!.validate(),
    ];
  }
}

/// JSON Converter for ContactData
class ContactDataJsonConverterNullable
    extends JsonConverter<ContactData?, Map<String, dynamic>?> {
  /// JSON Converter for ContactData
  const ContactDataJsonConverterNullable();

  @override
  ContactData? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$ContactDataFromJson(json);

  @override
  Map<String, dynamic>? toJson(ContactData? object) =>
      object == null ? null : _$ContactDataToJson(object);
}

/// JSON Converter for ContactData
class ContactDataJsonConverter
    extends JsonConverter<ContactData, Map<String, dynamic>> {
  /// JSON Converter for ContactData
  const ContactDataJsonConverter();

  @override
  ContactData fromJson(Map<String, dynamic> json) =>
      _$ContactDataFromJson(json);

  @override
  Map<String, dynamic> toJson(ContactData object) =>
      _$ContactDataToJson(object);
}

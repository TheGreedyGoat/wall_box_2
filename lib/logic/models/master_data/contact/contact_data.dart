import 'package:freezed_annotation/freezed_annotation.dart';
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
  final String id;
  @override
  final Phone? phone;
  @override
  final Phone? mobile;
  @override
  final Email? email;

  /// contains contact data such as phone numbers and an email address
  ContactData({
    required this.id,
    @PhoneJsonConverter() @JsonKey(name: 'phone') this.phone,
    @PhoneJsonConverter() @JsonKey(name: 'mobile') this.mobile,
    @EmailJsonConverter() @JsonKey(name: 'email') this.email,
  });

  @override
  get validationList => [
    phone == null && mobile == null ? DataError.noPhoneOrMobile : null,
    if (mobile != null) ...mobile!.validate(),
    if (phone != null) ...phone!.validate(),
    if (email != null) ...email!.validate(),
  ];
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

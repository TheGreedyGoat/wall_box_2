import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

/// Stores data for a customer.
///
/// A valid customer needs to have at least one of [company] & [personal] set
@freezed
@JsonSerializable(
  converters: [
    PersonalDataJsonConverterNullable(),
    CompanyDataJsonConverterNullable(),
    AddressJsonConverter(),
    ContactDataJsonConverter(),
  ],
)
class Customer extends MasterData with _$Customer {
  /// the id
  @override
  final String id;

  /// if the customer is a company
  @override
  final CompanyData? company;

  /// if the customer is a natural person
  ///
  /// Alternatively a contact person, boss etc. of the company
  @override
  final PersonalData? personal;

  final Address address;
  final ContactData contact;

  /// Stores data for a customer.
  ///
  /// A valid customer needs to have at least one of [company] & [personal] set
  Customer({
    required this.id,
    @AddressJsonConverter() @JsonKey(name: 'address') required this.address,
    @ContactDataJsonConverterNullable()
    @JsonKey(name: 'contact')
    required this.contact,
    @PersonalDataJsonConverterNullable() this.personal,
    @CompanyDataJsonConverterNullable() this.company,
  });

  @override
  List<DataError?> get validationList => [
    company == null && personal == null ? DataError.noCompanyOrPersonal : null,
    if (company != null) ...company!.validate(),
    if (personal != null) ...personal!.validate(),
  ];
}

class CustomerJsonConverter
    extends JsonConverter<Customer, Map<String, dynamic>> {
  const CustomerJsonConverter();

  @override
  Customer fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  @override
  Map<String, dynamic> toJson(Customer object) => _$CustomerToJson(object);
}

class CustomerJsonConverterNullable
    extends JsonConverter<Customer?, Map<String, dynamic>?> {
  const CustomerJsonConverterNullable();

  @override
  Customer? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$CustomerFromJson(json);

  @override
  Map<String, dynamic>? toJson(Customer? object) =>
      object == null ? null : _$CustomerToJson(object);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'address.freezed.dart';
part 'address.g.dart';

/// Represents an address
@freezed
@JsonSerializable()
class Address extends MasterData with _$Address {
  @override
  final String id;
  @override
  final String? street;
  @override
  final String? number;
  @override
  final String? postcode;
  @override
  final String? city;
  // optional
  @override
  final String? country;

  /// optional additional notes for the address (eg. 1st floor etc)
  @override
  final String? adressAdditions;

  /// Represents an address
  Address({
    required this.id,
    this.street,
    this.postcode,
    this.number,
    this.city,
    this.country,
    this.adressAdditions,
  });

  @override
  List<DataError?> get validationList => [
    (street ?? '').isEmpty ? DataError.noStreet : null,
    (number ?? '').isEmpty ? DataError.noHouseNumber : null,
    (postcode ?? '').isEmpty ? DataError.noPostcode : null,
    (city ?? '').isEmpty ? DataError.noCity : null,
  ];
}

/// Converter for adresses
class AddressJsonConverter
    extends JsonConverter<Address, Map<String, dynamic>> {
  /// Converter for adresses
  const AddressJsonConverter();

  @override
  Address fromJson(Map<String, dynamic> json) => _$AddressFromJson(json);
  @override
  Map<String, dynamic> toJson(Address object) => _$AddressToJson(object);
}

/// Converter for adresses
class AddressJsonConverterNullable
    extends JsonConverter<Address?, Map<String, dynamic>?> {
  /// Converter for adresses
  const AddressJsonConverterNullable();

  @override
  Address? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$AddressFromJson(json);
  @override
  Map<String, dynamic>? toJson(Address? object) =>
      object == null ? null : _$AddressToJson(object);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/address_table.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'address.freezed.dart';
part 'address.g.dart';

/// Represents an address
@freezed
@JsonSerializable()
class Address extends MasterData with _$Address {
  @override
  final String customerID;
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
  final String? state;
  @override
  final String? country;

  /// optional additional notes for the address (eg. 1st floor etc)
  @override
  final String? addressAdditions;

  /// Represents an address
  Address({
    @JsonKey(name: AddressColumns.customer_id) required this.customerID,
    @JsonKey(name: AddressColumns.street) this.street,
    @JsonKey(name: AddressColumns.house_number) this.number,
    @JsonKey(name: AddressColumns.postcode) this.postcode,
    @JsonKey(name: AddressColumns.city) this.city,
    @JsonKey(name: AddressColumns.state) this.state,
    @JsonKey(name: AddressColumns.country) this.country,
    @JsonKey(name: AddressColumns.adress_additions) this.addressAdditions,
  });

  @override
  List<DataError?> get validationList => [
    (city ?? '').isEmpty ? DataError.noCity : null,
    (country ?? '').isEmpty ? DataError.noCountry : null,
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

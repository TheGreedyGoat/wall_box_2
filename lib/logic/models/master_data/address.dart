import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
@JsonSerializable()
class Address extends MasterData with _$Address {
  final String id;
  final String? street;
  final String? number;
  final String? postcode;
  final String? city;
  // optional
  final String? country;
  final String? adressAdditions;

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

class AddressJsonConverter
    extends JsonConverter<Address?, Map<String, dynamic>?> {
  const AddressJsonConverter();

  @override
  Address? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$AddressFromJson(json);
  @override
  Map<String, dynamic>? toJson(Address? object) =>
      object == null ? null : _$AddressToJson(object);
}

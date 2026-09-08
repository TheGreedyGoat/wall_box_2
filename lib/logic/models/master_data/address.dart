import 'package:wall_box_2/logic/models/master_data/master_data.dart';

class Address extends MasterData {
  final String? street;
  final String? number;
  final String? postcode;
  final String? city;
  // optional
  final String? country;
  final String? adressAdditions;

  Address({
    required super.id,
    this.street,
    this.postcode,
    this.number,
    this.city,
    this.country,
    this.adressAdditions,
  });

  @override
  String? validate() {
    return super.processValidationList([
      (street ?? '').isEmpty ? 'Streetname not set' : null,
      (number ?? '').isEmpty ? 'house number not set' : null,
      (postcode ?? '').isEmpty ? 'Postcode not set' : null,
      (city ?? '').isEmpty ? 'city not set' : null,
    ]);
  }
}

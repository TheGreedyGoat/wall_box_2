import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'personal_data.freezed.dart';
part 'personal_data.g.dart';

@freezed
@JsonSerializable(
  converters: [ContactDataJsonConverter(), AddressJsonConverter()],
)
/// contains data about a natural person
class PersonalData extends MasterData with _$PersonalData {
  final String id;
  final String? prename;
  final String? surname;
  final ContactData? contact;
  final Address? address;

  PersonalData({
    required this.id,
    this.prename,
    this.surname,
    @ContactDataJsonConverter() @JsonKey(name: 'contact') this.contact,
    @AddressJsonConverter() @JsonKey(name: 'address') this.address,
  });

  String nonNull(String? Function(PersonalData data) getValue) =>
      getValue(this) ?? '';

  Map<String, dynamic> toJson() => _$PersonalDataToJson(this);

  @override
  List<DataError?> get validationList => [
    (prename ?? '').isEmpty ? DataError.noPrename : null,
    (surname ?? '').isEmpty ? DataError.noSurname : null,
    address == null ? DataError.noAddress : null,
    contact == null ? DataError.noContact : null,
    if (address != null) ...address!.validate(),
    if (contact != null) ...contact!.validate(),
  ];
}

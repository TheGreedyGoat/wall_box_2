import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'company_data.freezed.dart';
part 'company_data.g.dart';

@freezed
@JsonSerializable(
  converters: [ContactDataJsonConverter(), AddressJsonConverter()],
)
/// represents data for a company
///
/// All fields are required for validation
class CompanyData extends MasterData with _$CompanyData {
  @override
  final String id;
  @override
  final String? companyName;
  @override
  final Address? address;
  @override
  final ContactData? contact;

  /// represents data for a company
  ///
  /// All fields are required for validation
  CompanyData({
    required this.id,
    this.companyName,
    @AddressJsonConverter() @JsonKey(name: 'address') this.address,
    @ContactDataJsonConverter() @JsonKey(name: 'contact') this.contact,
  });

  @override
  List<DataError?> get validationList => [
    (companyName ?? '').isEmpty ? DataError.noCompanyName : null,
    address == null ? DataError.noAddress : null,
    contact == null ? DataError.noContact : null,
    if (address != null) ...address!.validate(),
    if (contact != null) ...contact!.validate(),
  ];
}

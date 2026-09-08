import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

class CompanyData extends MasterData {
  final String? companyName;
  final Address? adress;
  final Contact? contact;

  CompanyData({required super.id, this.companyName, this.adress, this.contact});

  @override
  String? validate() {
    return super.processValidationList([
      (companyName ?? '').isEmpty ? 'no company name provided' : null,
      adress == null ? 'adress missing' : null,
      contact == null ? 'contact missing' : null,
      adress?.validate(),
      contact?.validate(),
    ]);
  }
}

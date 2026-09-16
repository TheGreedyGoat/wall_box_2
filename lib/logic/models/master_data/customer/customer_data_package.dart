import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal/personal_data.dart';

part 'customer_data_package.freezed.dart';

@freezed
class CustomerDataPackage extends MasterData with _$CustomerDataPackage {
  final Customer customer;
  final Address address;
  final ContactData? contact;
  final CompanyData? company;
  final PersonalData? personal;

  String get id => customer.id;

  String? get companyName => company?.companyName;
  String? get personalName => personal != null
      ? '${personal!.prename ?? ''} ${personal!.surname}'
      : null;
  String get displayName => companyName ?? personalName ?? id;

  CustomerDataPackage({
    required this.customer,
    required this.address,
    required this.contact,
    required this.company,
    required this.personal,
  });

  @override
  List<DataError?> get validationList => [
    if (id.trim().isEmpty) DataError.noID,
    ...customer.validate(),
    ...address.validate(),
    if ((company?.companyName?.trim() ?? '').isEmpty &&
        (personal?.surname?.trim() ?? '').isEmpty)
      DataError.noCompanyOrPersonal,
    if (contact != null) ...contact!.validate(),
    if (company != null) ...company!.validate(),
    if (personal != null) ...personal!.validate(),
  ];

  static CustomerDataPackage get empty => CustomerDataPackage(
    customer: Customer(id: ''),
    address: Address(customerID: ''),
    contact: null,
    company: null,
    personal: null,
  );
}

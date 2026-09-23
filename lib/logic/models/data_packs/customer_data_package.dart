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
/// Unifies all CustomerMAstaerData within a single but still modular data pack
class CustomerDataPackage extends MasterData with _$CustomerDataPackage {
  @override
  final Customer customer;
  @override
  final Address address;
  @override
  final ContactData? contact;
  @override
  final CompanyData? company;
  @override
  final PersonalData? personal;

  /// Quick access to the customer's id
  String get id => customer.id;

  /// quick access to the companie's name
  String? get companyName => company?.companyName;

  /// quick access to the person's name
  String? get personalName => personal != null
      ? '${personal!.prename ?? ''} ${personal!.surname}'.trimLeft()
      : null;

  /// returns the company name or the personal name or the id (wichever is the first in that order not to be null)
  String get displayName => companyName ?? personalName ?? id;

  CustomerDataPackage._({
    required this.customer,
    required this.address,
    this.contact,
    this.company,
    this.personal,
  });

  static CustomerDataPackage get unknown => CustomerDataPackage._(
    customer: Customer(id: 'XXXXXX'),
    address: Address(customerID: 'XXXXXX'),
    personal: PersonalData(customerID: 'XXXXXX', surname: 'UNBEKANNT'),
  );

  /// creates a new package.
  ///
  /// Automatically sets all component's customer id to the id int the Customer instance
  factory CustomerDataPackage({
    required Customer customer,
    required Address address,
    required ContactData? contact,
    CompanyData? company,
    PersonalData? personal,
  }) {
    return CustomerDataPackage._(
      customer: customer,
      address: address.copyWith(customerID: customer.id),
      contact: contact?.copyWith(customerID: customer.id),
      company: company?.copyWith(customerID: customer.id),
      personal: personal?.copyWith(customerID: customer.id),
    );
  }

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

  /// returns a blank package
  static CustomerDataPackage get empty => CustomerDataPackage(
    customer: Customer(id: ''),
    address: Address(customerID: ''),
    contact: null,
    company: null,
    personal: null,
  );
}

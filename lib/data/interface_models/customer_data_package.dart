import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';
import 'package:wall_box_2/data/repositories/address_repo.dart';
import 'package:wall_box_2/data/repositories/company_repo.dart';
import 'package:wall_box_2/data/repositories/contact_repo.dart';
import 'package:wall_box_2/data/repositories/personal_repo.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/customer.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';

part '../repositories/customer_repo.dart';
part 'customer_data_package.freezed.dart';

@freezed
class CustomerDataPackage with _$CustomerDataPackage {
  final Customer customer;
  final Address address;
  final ContactData? contact;
  final CompanyData? company;
  final PersonalData? personal;

  String get id => customer.id;

  CustomerDataPackage({
    required this.customer,
    required this.address,
    required this.contact,
    required this.company,
    required this.personal,
  });

  Future<void> insert() async {
    assert(company != null || personal != null);
    assert(customer.id == address.customerID);
    assert(contact == null || customer.id == contact!.customerID);
    assert(company == null || customer.id == company!.customerID);
    assert(personal == null || customer.id == personal!.customerID);

    assert(customer.isValid);
    assert(address.isValid);
    assert(contact?.isValid ?? true);
    assert(company?.isValid ?? true);
    assert(personal?.isValid ?? true);

    final db = await AppDatabase.instance.database;

    await _CustomerRepo().insert(customer);
    await AddressRepo().insert(address);
    if (contact != null) await ContactRepo().insert(contact!);
    if (company != null) await CompanyRepo().insert(company!);
    if (personal != null) await PersonalRepo().insert(personal!);
  }

  List<DataError> validate() => [
    ...customer.validate(),
    ...address.validate(),
    if (contact != null) ...contact!.validate(),
    if (company != null) ...company!.validate(),
    if (personal != null) ...personal!.validate(),
  ];
}

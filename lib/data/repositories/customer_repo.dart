import 'package:my_utils/utility/logger/logger.dart';
import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/data/repositories/address_repo.dart';
import 'package:wall_box_2/data/repositories/company_repo.dart';
import 'package:wall_box_2/data/repositories/contact_repo.dart';
import 'package:wall_box_2/data/repositories/personal_repo.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer.dart';

/// Repository for Customers
class CustomerRepo extends Repository<Customer> {
  /// Repository for Customers
  CustomerRepo({required super.onchanged})
    : super(primaryKeyColumns: [CustomerColumns.id]);

  @override
  String get tableName => TableNames.customer;

  @override
  CustomerJsonConverter get converter => CustomerJsonConverter();

  /// get the customer with the passed id
  Future<Customer?> getByID(String id) async {
    final db = await database;

    final qu = await db.query(
      tableName,
      where: '${CustomerColumns.id} = ?',
      whereArgs: [id],
    );
    return qu.isEmpty ? null : converter.fromJson(qu[0]);
  }

  /// Check if a customer with the passed d exists
  Future<bool> checkID(String customerID) async {
    return (await query(
      where: '${CustomerColumns.id} = ?',
      whereArgs: [customerID],
    )).isNotEmpty;
  }

  Future<CustomerDataPackage?> queryPackage(String customerID) async {
    final logger = Logger(CustomerRepo, 'queryPackage');
    try {
      final customer = await getByID(customerID);
      assert(customer != null, 'No customer with ID $customerID found');

      final company = await CompanyRepo(onchanged: null).getByID(customerID);
      final personals = await PersonalRepo(onchanged: null).getByID(customerID);
      final address = await AddressRepo(onchanged: null).getByID(customerID);
      assert(
        address != null,
        'Did not find any addres data for customer $customerID',
      );

      final contact = await ContactRepo(onchanged: null).getByID(customerID);

      return CustomerDataPackage(
        customer: customer!,
        address: address!,
        contact: contact,
        company: company,
        personal: personals,
      );
    } catch (e) {
      logger.call(e, 1, false);
      return null;
    }
  }
}

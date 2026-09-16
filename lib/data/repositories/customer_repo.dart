import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer.dart';

class CustomerRepo extends Repository<Customer> {
  CustomerRepo({required super.onchanged});

  @override
  String get tableName => TableNames.customer;

  @override
  CustomerJsonConverter get converter => CustomerJsonConverter();

  Future<Customer?> getByID(String id) async {
    final db = await database;

    final qu = await db.query(
      tableName,
      where: '${CustomerColumns.id} = ?',
      whereArgs: [id],
    );
    return qu.isEmpty ? null : converter.fromJson(qu[0]);
  }

  // Future<CustomerDataPackage?> getFullCustomerData(Customer customer) async {
  //   try {
  //     return CustomerDataPackage(
  //       customer: customer,
  //       address: address,
  //       contact: contact,
  //       company: company,
  //       personal: personal,
  //     );
  //   } catch (e) {
  //     return null;
  //   }
  // }
}

import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/repository.dart';
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
}

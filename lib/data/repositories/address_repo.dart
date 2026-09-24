import 'package:wall_box_2/data/database/tables/address_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';

/// The Reopsitory for all address data
class AddressRepo extends Repository<Address> {
  /// The Reopsitory for all address data
  AddressRepo({required super.onchanged})
    : super(primaryKeyColumns: [AddressColumns.customer_id]);

  @override
  String get tableName => TableNames.address;

  @override
  AddressJsonConverter get converter => AddressJsonConverter();

  /// Returns a customer's address
  Future<Address?> getByID(String customerID) async {
    final db = await database;
    final query = await db.query(
      tableName,
      where: '${AddressColumns.customer_id} = ?',
      whereArgs: [customerID],
    );

    if (query.isNotEmpty) {
      return converter.fromJson(query[0]);
    }
    return null;
  }
}

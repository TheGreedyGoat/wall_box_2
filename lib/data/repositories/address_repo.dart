import 'package:wall_box_2/data/database/tables/address_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';

class AddressRepo extends Repository<Address> {
  AddressRepo({required super.onchanged});

  @override
  String get tableName => TableNames.address;

  @override
  AddressJsonConverter get converter => AddressJsonConverter();

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
  }
}

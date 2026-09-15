import 'package:sqflite/sqflite.dart';
import 'package:wall_box_2/data/database/tables/address_table.dart';
import 'package:wall_box_2/data/database/tables/company_table.dart';
import 'package:wall_box_2/data/database/tables/contact_table.dart';
import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/personal_table.dart';
import 'package:wall_box_2/data/database/tables/price_assignment_table.dart';
import 'package:wall_box_2/data/database/tables/tag_assignment_table.dart';
import 'package:wall_box_2/data/database/tables/transaction_table.dart';

class DatabaseSchema {
  static Future<void> create(Database db, int version) async {
    await db.execute(CustomerTable.create);

    await db.execute(AddressTable.create);
    await db.execute(CompanyTable.create);
    await db.execute(ContactTable.create);
    await db.execute(PersonalTable.create);
    await db.execute(PriceAssignmentTable.create);
    await db.execute(TagAssignmentTable.create);

    await db.execute(TransactionTable.create);
  }

  static Future<void> upgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // await db.execute('ALTER TABLE customers ADD COLUMN ...');
    }
  }
}

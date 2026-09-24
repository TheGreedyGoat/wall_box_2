import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wall_box_2/data/database/core/database_schema.dart';
import 'package:wall_box_2/data/database/tables/address_table.dart';
import 'package:wall_box_2/data/database/tables/company_table.dart';
import 'package:wall_box_2/data/database/tables/contact_table.dart';
import 'package:wall_box_2/data/database/tables/personal_table.dart';
import 'package:wall_box_2/data/database/tables/price_assignment_table.dart';
import 'package:wall_box_2/data/database/tables/tag_assignment_table.dart';
import 'package:wall_box_2/data/database/tables/transaction_table.dart';

/// core access to the database (singleton)
///
/// Only contains the most general functions
///
/// Manage the database structure in [DatabaseSchema]
///
/// Functions for specific models/ tables are within ther own [Repository] class
///
class AppDatabase {
  /// The name of the main database actually used for the app (and not for tests etc)
  static const mainDB = 'wb_database';

  ///
  static final AppDatabase instance = AppDatabase._(mainDB);

  /// core access to the database
  ///
  /// Only contains the most general functions
  ///
  /// Manage the database structure in [DatabaseSchema]
  ///
  /// Functions for specific models/ tables are within ther own [Repository] class
  ///
  final String databaseName;
  AppDatabase._(this.databaseName);
  Database? _database;

  /// opens the database and gives access to it
  Future<Database> get database async {
    return _database ??= await _openDatabase();
  }

  Future<Database> _openDatabase() async {
    final path = join(await getDatabasesPath(), '$databaseName.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: DatabaseSchema.create,
      onUpgrade: DatabaseSchema.upgrade,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// queries all rows from every table
  Future<List<dynamic>> queryAll() async {
    final db = await database;
    return [
      for (final table in [
        AddressTable.name,
        CompanyTable.name,
        ContactTable.name,
        PersonalTable.name,
        PriceAssignmentTable.name,
        TagAssignmentTable.name,
        TransactionTable.name,
      ]) ...[table, ...(await db.query(table))],
    ];
  }

  /// # DANGER ZONE!
  ///
  /// deletes the whole database. Use at own risk.
  ///
  ///
  /// I warned you.
  Future<void> delete() async {
    final path = join(await getDatabasesPath(), '$databaseName.db');
    if ((await databaseExists(path))) await deleteDatabase(path);
  }
}

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wall_box_2/data/database/core/database_schema.dart';

class AppDatabase {
  static const mainDB = 'wb_database';
  static final AppDatabase instance = AppDatabase._(mainDB);

  final String databaseName;
  AppDatabase._(this.databaseName);
  Database? _database;

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
    );
  }

  Future<void> delete() async {
    final path = join(await getDatabasesPath(), '$databaseName.db');
    if ((await databaseExists(path))) await deleteDatabase(path);
  }
}

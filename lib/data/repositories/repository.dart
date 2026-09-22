import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';

/// Base class for model repositories
///
/// Each implementation of this class should represent one database table
///
/// [T] : the thype of object to store within the table
///
/// If creating a new repsitory a corresponding Table- and Columnclass should be created aswell and the [DatabaseSchema] should be updated
///
abstract class Repository<T> {
  /// Used to convert database table rows to model objects and vice verca.
  JsonConverter<T, Map<String, Object?>> get converter;

  /// quick access to the database;
  Future<Database> get database async => await AppDatabase.instance.database;

  /// quick access to the corresponding databes table's name
  String get tableName;

  /// Logic to invoke whenever this repo updates it's content.
  ///
  /// Mainly used to notify the ChangeNotifier
  final void Function() onchanged;

  /// Base class for model repositories
  ///
  /// Each implementation of this class should represent one database table
  ///
  /// [T] : the thype of object to store within the table
  ///
  /// If creating a new repsitory a corresponding Table- and Columnclass should be created aswell and the [DatabaseSchema] should be updated
  ///
  /// Mainly used to notify the ChangeNotifier
  Repository({required this.onchanged});

  /// inserts an instance of T to the database
  Future<int> insert(
    T value, [
    ConflictAlgorithm onConflict = ConflictAlgorithm.replace,
  ]) async {
    final db = await database;
    final changes = await db.insert(
      tableName,
      converter.toJson(value),
      conflictAlgorithm: onConflict,
    );
    if (changes != 0) {
      onchanged();
    }
    return changes;
  }

  /// Inserts multiple instances of [T] at once
  ///
  ///
  Future<int> insertAll(
    List<T> values, [
    ConflictAlgorithm onConflict = ConflictAlgorithm.replace,
  ]) async {
    final db = await database;
    int changes = 0;
    for (final v in values) {
      changes += await db.insert(
        tableName,
        converter.toJson(v),
        conflictAlgorithm: onConflict,
      );
    }
    if (changes != 0) onchanged();
    return changes;
  }

  /// returns the whole table's content
  Future<List<T>> get allRows async {
    final db = await database;
    final rows = await db.query(tableName);
    return rows.map(
      (e) {
        return converter.fromJson(e);
      },
    ).toList();
  }

  /// Find the first row that satisfies where
  Future<T?> get(String where, List<String> whereArgs) async {
    final db = await database;
    final res = (await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      limit: 1,
    )).firstOrNull;
    return res != null ? converter.fromJson(res) : null;
  }

  Future<List<T>> getMultiple({String? where, List<String>? whereArgs}) async {
    final qu = await query(where: where, whereArgs: whereArgs);
    return qu
        .map(
          (e) => converter.fromJson(e),
        )
        .toList();
  }

  /// deletes all rows that satisfy the where conditions.
  ///
  /// Returns the number of changes made
  Future<int> delete({String? where, List<String>? whereArgs}) async {
    final db = await database;

    final changes = await db.delete(
      tableName,
      where: where,
      whereArgs: whereArgs,
    );
    if (changes != 0) onchanged();
    return changes;
  }

  /// send a query to the table
  Future<List<Map<String, Object?>>> query({
    String? where,
    List<String>? whereArgs,
    List<String>? columns,
    String? groupBy,
    String? having,
    bool? distinct,
  }) async {
    final db = await database;
    return await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
      columns: columns,
      distinct: distinct,
      groupBy: groupBy,
      having: having,
    );
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:my_utils/utility/logger/logger.dart';
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

  /// The naimes of the columns wich are primary keys
  final List<String> primaryKeyColumns;

  /// Logic to invoke whenever this repo updates it's content.
  ///
  /// Mainly used to notify the ChangeNotifier
  final void Function()? onchanged;

  /// Base class for model repositories
  ///
  /// Each implementation of this class should represent one database table
  ///
  /// [T] : the thype of object to store within the table
  ///
  /// If creating a new repsitory a corresponding Table- and Columnclass should be created aswell and the [DatabaseSchema] should be updated
  ///
  /// Mainly used to notify the ChangeNotifier
  Repository({required this.onchanged, required this.primaryKeyColumns});

  /// directly pass your database changes here to trigger the change callback if change > 0
  ///
  /// returns the changes (in = out)
  int checkChange(int changeCount) {
    if (changeCount != 0) onchanged!.call();
    return changeCount;
  }

  /// Ensures we only write if [onchanged] is set, so notifiers get updated
  bool get writeAllowed {
    final allowed = onchanged != null;
    if (!allowed) {
      Logger(
        this.runtimeType,
        'writeAllowed',
      ).call('Tried Writing a readonly Repositiory!', 2, false);
    }
    return allowed;
  }
  //  #     #
  //  #  #  # #####  # ##### ######
  //  #  #  # #    # #   #   #
  //  #  #  # #    # #   #   #####
  //  #  #  # #####  #   #   #
  //  #  #  # #   #  #   #   #
  //   ## ##  #    # #   #   ######

  /// inserts an instance of T to the database
  ///
  /// returns the number of changes made to the database
  Future<int> insert(
    T value, [
    ConflictAlgorithm onConflict = ConflictAlgorithm.replace,
  ]) async {
    if (!writeAllowed) return 0;
    final db = await database;
    return checkChange(
      await db.insert(
        tableName,
        converter.toJson(value),
        conflictAlgorithm: onConflict,
      ),
    );
  }

  /// Inserts multiple instances of [T] at once
  ///
  /// returns the number of changes made to the database
  Future<int> insertAll(
    List<T> values, [
    ConflictAlgorithm onConflict = ConflictAlgorithm.replace,
  ]) async {
    if (!writeAllowed) return 0;
    final db = await database;
    int changes = 0;
    for (final v in values) {
      changes += await db.insert(
        tableName,
        converter.toJson(v),
        conflictAlgorithm: onConflict,
      );
    }
    return checkChange(changes);
  }

  /// Updates the table of [original] with all values that are different in [changed]
  ///
  /// if [changed] = null or primary keys of [original] and [changed] don't match, no change is made.
  ///
  /// [insertOnNoOriginal] causes change to be inserted as a new row if [original] is null
  ///
  /// returns the number of changes made to the database
  Future<int> update(
    T? original,
    T? changed, [
    bool insertOnNoOriginal = true,
  ]) async {
    if (!writeAllowed) return 0;
    // no changes provided => leave immediately
    if (changed == null) return 0;
    // no original => insert new
    if (original == null) {
      return insertOnNoOriginal ? await insert(changed) : 0;
    }

    // print('changing \n$original\nto\n$changed');

    final changes = getUpdates(original, changed);
    if (changes.isEmpty) return 0;
    // print('changes: $changes');
    final db = await database;
    return checkChange(
      await db.update(
        tableName,
        changes,
        where: primaryWhere,
        whereArgs: getPrimaryWhereArgs(original),
      ),
    );
  }

  /// Compares [original] with [changed] and returns a map of all values in [changed] that differ from [original]
  ///
  /// both passed objects need to have the same primary key, otherwise an empty map will be returned
  ///
  Map<String, Object?> getUpdates(
    T original,
    T changed,
  ) {
    final originalJson = converter.toJson(original);
    final changedJson = converter.toJson(changed);
    bool samePK = primaryKeyColumns.fold(
      true,
      (previousValue, pk) {
        return previousValue && originalJson[pk] == changedJson[pk];
      },
    );
    if (!samePK) {
      return {};
    }
    final result = Map.fromEntries(
      changedJson.entries.where(
        (entry) {
          return originalJson[entry.key] != entry.value;
        },
      ),
    );
    return result;
  }

  /// Deletes the row with the same PK value(s) as [object]
  ///
  /// returns the number of changes made to the database
  Future<int> deleteByPrimaries(T object) async {
    if (!writeAllowed) return 0;
    String where = '';
    final whereArgs = <String>[];
    final pks = getPrimaryKeys(object).entries.toList();

    for (int i = 0; i < pks.length - 1; i++) {
      final pk = pks[i];
      where += '${pk.key} = ? AND\n';
      whereArgs.add(pk.value.toString());
    }
    where += '${pks.last.key} = ?';
    whereArgs.add(pks.last.value.toString());

    return await delete(
      where: where,
      whereArgs: whereArgs,
    );
  }

  /// deletes all rows that satisfy the where conditions.
  ///
  /// Returns the number of changes made to the database
  Future<int> delete({String? where, List<String>? whereArgs}) async {
    if (!writeAllowed) return 0;
    final db = await database;

    return checkChange(
      await db.delete(
        tableName,
        where: where,
        whereArgs: whereArgs,
      ),
    );
  }

  //  ######
  //  #     # ######   ##   #####
  //  #     # #       #  #  #    #
  //  ######  #####  #    # #    #
  //  #   #   #      ###### #    #
  //  #    #  #      #    # #    #
  //  #     # ###### #    # #####

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

  /// get a list of rows wich fulfill [where] converted to instances of [T].
  ///
  /// PAssing null to where & whereArgs returns the whole table
  Future<List<T>> getMultiple({String? where, List<String>? whereArgs}) async {
    final qu = await queryAsJson(where: where, whereArgs: whereArgs);
    return qu
        .map(
          (e) => converter.fromJson(e),
        )
        .toList();
  }

  /// send a query to the table
  Future<List<Map<String, Object?>>> queryAsJson({
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

  Future<List<T>> queryAsObjects({
    String? where,
    List<String>? whereArgs,
    List<String>? columns,
    String? groupBy,
    String? having,
    bool? distinct,
  }) async {
    final qu = await queryAsJson(
      where: where,
      whereArgs: whereArgs,
      columns: columns,
      groupBy: groupBy,
      having: having,
      distinct: distinct,
    );

    return qu.map(
      (e) {
        return converter.fromJson(e);
      },
    ).toList();
  }

  /// extracts only the primary keys from the objects json
  ///
  Map<String, Object?> getPrimaryKeys(T? object) {
    return object == null
        ? {}
        : Map.fromEntries(
            converter
                .toJson(object)
                .entries
                .where(
                  (entry) => primaryKeyColumns.contains(entry.key),
                )
                .toList(),
          );
  }

  /// builds a where sql filtering for the primary keys of this table
  ///
  /// the order of primary keys is the same as in [primaryKeyColumns]
  String get primaryWhere {
    return primaryKeyColumns.fold(
      '',
      (sql, pk) {
        return '$sql $pk = ?${primaryKeyColumns.lastOrNull != pk ? ' AND' : ''}';
      },
    );
  }

  /// returns the primary key values from [object].
  /// Can be used directly as whereArgs in queries
  ///
  /// the order of values is the same as in [primaryKeyColumns]
  ///
  List<Object?> getPrimaryWhereArgs(T object) {
    final entries = getPrimaryKeys(object).entries.toList();
    entries.sort(
      (a, b) {
        final aIndex = primaryKeyColumns.indexOf(a.key);
        final bIndex = primaryKeyColumns.indexOf(b.key);

        return aIndex.compareTo(bIndex);
      },
    );
    return entries
        .map(
          (e) => e.value,
        )
        .toList();
  }
}

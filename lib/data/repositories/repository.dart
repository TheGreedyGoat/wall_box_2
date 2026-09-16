import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';

abstract class Repository<T> {
  JsonConverter<T, dynamic> get converter;
  Future<Database> get database async => await AppDatabase.instance.database;
  String get tableName;

  final void Function() onchanged;

  Repository({required this.onchanged});

  Future<void> insert(T value) async {
    final db = await database;
    final changes = await db.insert(
      tableName,
      converter.toJson(value),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (changes != 0) {
      onchanged();
      print('Repo has changed');
    }
  }

  Future<void> insertAll(List<T> values) async {
    for (final e in values) {
      await insert(e);
    }
  }

  Future<List<T>> get allRows async {
    final db = await database;
    final rows = await db.query(tableName);
    return rows.map(
      (e) {
        return converter.fromJson(e);
      },
    ).toList();
  }

  Future<T?> get(String where, List<String> whereArgs) async {
    final db = await database;
    final res = (await db.query(
      tableName,
      where: where,
      whereArgs: whereArgs,
    )).firstOrNull;
    if (res != null) {
      return converter.fromJson(res);
    }
  }

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

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';

abstract class Repository<T> {
  JsonConverter get converter;
  AppDatabase get database => AppDatabase.instance;
  String get tableName;

  Future<void> insert(T value) async {
    final db = await database.database;
    await db.insert(tableName, converter.toJson(value));
  }
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/known_logs_table.dart';
import 'package:wall_box_2/data/database/repository.dart';

class KnownLogsRepo extends Repository<String> {
  KnownLogsRepo({required super.onchanged})
    : super(primaryKeyColumns: [KnownLogsColumns.head]);

  @override
  JsonConverter<String, Map<String, String>> get converter =>
      _KnownLogsHeadConverter();

  @override
  String get tableName => KnownLogsTable.name;

  Future<bool> doesExist(String head) async => (await query(
    where: '${KnownLogsColumns.head} = ?',
    whereArgs: [head],
  )).isNotEmpty;
}

class _KnownLogsHeadConverter
    extends JsonConverter<String, Map<String, String>> {
  const _KnownLogsHeadConverter();
  @override
  String fromJson(Map<String, String> json) => json.values.first;

  @override
  Map<String, String> toJson(String object) => {KnownLogsColumns.head: object};
}

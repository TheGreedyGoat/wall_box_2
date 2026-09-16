import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/tables/tag_assignment_table.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';

class TagAssignmentRepo extends Repository<TagAssignment> {
  TagAssignmentRepo({required super.onchanged});

  static const tagIDColumn = TagAssignmentColumns.tag_id;
  static const fromVolumn = TagAssignmentColumns.from;
  static const toColumn = TagAssignmentColumns.to;
  static const customerColumn = TagAssignmentColumns.customer_id;

  @override
  TagAssignmentJsonConverter get converter => TagAssignmentJsonConverter();

  @override
  String get tableName => TableNames.tagAssignment;

  Future<TagAssignment?> tagAtDate({
    required String tagID,
    required DateTime date,
  }) async {
    final dateString = date.toIso8601String();
    final rows = await query(
      where:
          '''
      ${tagIDColumn} = ?
      AND $fromVolumn <= ?
      AND ($toColumn IS NULL OR $toColumn >= ?)
      ''',
      whereArgs: [tagID, dateString, dateString],
    );
    final result = rows.firstOrNull;
    if (result != null) return converter.fromJson(result);
  }

  Future<List<TagAssignment>> assignmentsByCustomer({
    required String customerID,
  }) async {
    final rows = await query(
      where: '$customerColumn = ?',
      whereArgs: [customerID],
    );
    return rows
        .map(
          (r) => converter.fromJson(r),
        )
        .toList();
  }

  Future<DateTime?> latestAvailableDate(String tagID) async {
    final rows = await query(where: '$tagIDColumn = ?', whereArgs: [tagID]);
    if (rows
        .where(
          // is still assigned atm
          (row) => row[toColumn] == null,
        )
        .isNotEmpty) {
      return null;
    }

    return rows.isEmpty
        ? DateTime.now().subtract(Duration(days: 365))
        : rows.fold<DateTime?>(
            null,
            (previousValue, json) {
              final to = converter.fromJson(json).to!;
              return previousValue == null || to.isAfter(previousValue)
                  ? to
                  : previousValue;
            },
          );
  }

  Future<bool> isAvailable(String tagID) async =>
      (await latestAvailableDate(tagID)) != null;
}

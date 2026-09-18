import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/tables/tag_assignment_table.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';

///
class TagAssignmentRepo extends Repository<TagAssignment> {
  ///
  TagAssignmentRepo({required super.onchanged});

  /// quick assets to the column's name
  static const tagIDColumn = TagAssignmentColumns.tag_id;

  /// quick assets to the column's name
  static const fromVolumn = TagAssignmentColumns.from;

  /// quick assets to the column's name
  static const toColumn = TagAssignmentColumns.to;

  /// quick assets to the column's name
  static const customerColumn = TagAssignmentColumns.customer_id;

  @override
  TagAssignmentJsonConverter get converter => TagAssignmentJsonConverter();

  @override
  String get tableName => TableNames.tagAssignment;

  /// tries to fiend an assigment for this tagID that covers the passed date
  Future<TagAssignment?> ofTagAtDate({
    required String tagID,
    required DateTime date,
  }) async {
    final dateString = date.toIso8601String();
    final rows = await query(
      where:
          '''
      $tagIDColumn = ?
      AND $fromVolumn <= ?
      AND ($toColumn IS NULL OR $toColumn >= ?)
      ''',
      whereArgs: [tagID, dateString, dateString],
    );
    final result = rows.firstOrNull;
    return result != null ? converter.fromJson(result) : null;
  }

  /// returns all assigments of a customer
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

  /// Finds the earliest possible when the tag can be asigned again.
  ///
  /// That date is either:
  /// - null if it is already assigned at this moment => has to be unassigned first
  /// - the end of the last assignment (if none is active right now)
  /// - today - 1 year, if there aren't any assignments for this tagID yet
  Future<DateTime?> earliestAvailableDate(String tagID) async {
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

  Future<int> deleteWhereTagID(String tagID) async {
    return await delete(
      where: '${TagAssignmentColumns.tag_id} = ?',
      whereArgs: [tagID],
    );
  }

  /// returns if this [tagID] is not already assigned right now
  Future<bool> isAvailable(String tagID) async =>
      (await earliestAvailableDate(tagID)) != null;
}

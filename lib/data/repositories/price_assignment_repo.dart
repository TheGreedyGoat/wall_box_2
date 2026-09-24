import 'package:wall_box_2/data/database/tables/price_assignment_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/data/repositories/personal_repo.dart';
import 'package:wall_box_2/logic/models/assignments/price_assignment.dart';

/// Stores prices assigned to customers
class PriceAssignmentRepo extends Repository<PriceAssignment> {
  /// Stores prices assigned to customers
  PriceAssignmentRepo({required super.onchanged})
    : super(
        primaryKeyColumns: [
          PriceAssignmentColumns.customer_id,
          PriceAssignmentColumns.from,
        ],
      );

  @override
  PriceAssignmentJsonConverter get converter => PriceAssignmentJsonConverter();

  @override
  String get tableName => TableNames.priceAssignment;

  /// An assignment is considered active, if the value of o is null.
  ///
  /// If there is a [PriceAssignment] that is active right now, it gets returned
  Future<PriceAssignment?> getActiveAssignment(String customerID) async {
    final qu = await query(
      where:
          '''
    ${PriceAssignmentColumns.customer_id} = ?
    AND ${PriceAssignmentColumns.to} IS NULL
''',
      whereArgs: [customerID],
    );
    if (qu.isNotEmpty) {
      return converter.fromJson(qu[0]);
    }
    return null;
  }

  /// Tries to find a [PriceAssignment] for the corresponding[customerID]
  /// wich covers the given date and returns it if found
  Future<PriceAssignment?> assignmentAtDate({
    required String customerID,
    required DateTime date,
  }) async {
    final dateString = date.toIso8601String();
    final rows = await query(
      where:
          '''
      ${PriceAssignmentColumns.customer_id} = ?
      AND ${PriceAssignmentColumns.from} <= ?
      AND (${PriceAssignmentColumns.to} IS NULL OR ${PriceAssignmentColumns.to} >= ?)
      ''',
      whereArgs: [customerID, dateString, dateString],
    );
    final result = rows.firstOrNull;
    if (result != null) return converter.fromJson(result);
    return null;
  }

  /// Finds the earliest possible date to assign a new price to.
  ///
  /// That date is either:
  /// - the start date of the currently active assignment
  /// - the end of the last assignment (if none is active right now)
  /// - todey - 1 year, if there aren't any assignments for this customer yet
  Future<DateTime> getEarliestAvailablePriceassignmentDate(
    String customerID,
  ) async {
    final db = await database;
    final qu = await db.rawQuery(
      '''
SELECT COALESCE(
  (SELECT ${PriceAssignmentColumns.from} FROM $tableName WHERE ${PriceAssignmentColumns.customer_id} = ? AND ${PriceAssignmentColumns.to} IS NULL LIMIT 1),

  (SELECT MAX(${PriceAssignmentColumns.to}) FROM $tableName WHERE ${PriceAssignmentColumns.customer_id} = ?),

  datetime('now', '-1 year')
) AS result;
''',
      [customerID, customerID],
    );

    return DateTime.parse(qu[0]['result'].toString());
  }
}

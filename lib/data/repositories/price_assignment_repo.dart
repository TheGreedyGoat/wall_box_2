import 'package:json_annotation/src/json_converter.dart';
import 'package:wall_box_2/data/database/tables/price_assignment_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/assignments/price_assignment.dart';

class PriceAssignmentRepo extends Repository<PriceAssignment> {
  PriceAssignmentRepo({required super.onchanged});

  @override
  PriceAssignmentJsonConverter get converter => PriceAssignmentJsonConverter();

  @override
  String get tableName => TableNames.priceAssignment;

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
  }
}

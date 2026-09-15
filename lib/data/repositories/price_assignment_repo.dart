import 'package:json_annotation/src/json_converter.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/assignments/price_assignment.dart';

class PriceAssignmentRepo extends Repository<PriceAssignment> {
  @override
  PriceAssignmentJsonConverter get converter => PriceAssignmentJsonConverter();

  @override
  String get tableName => TableNames.priceAssignment;
}

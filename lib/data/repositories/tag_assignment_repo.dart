import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';

class TagAssignmentRepo extends Repository<TagAssignment> {
  @override
  TagAssignmentJsonConverter get converter => TagAssignmentJsonConverter();

  @override
  String get tableName => TableNames.tagAssignment;
}

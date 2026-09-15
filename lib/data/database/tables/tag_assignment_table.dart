import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class TagAssignmentTable {
  static const name = TableNames.tagAssignment;

  static const create =
      '''
CREATE TABLE $name (
  ${TagAssignmentColumns.tag_id} TEXT NOT NULL,
  ${TagAssignmentColumns.customer_id} TEXT NOT NULL,
  ${TagAssignmentColumns.from} TEXT NOT NULL,
  ${TagAssignmentColumns.to}  TEXT,
  PRIMARY KEY (${TagAssignmentColumns.tag_id}, 
  ${TagAssignmentColumns.from}),
    FOREIGN KEY(${TagAssignmentColumns.customer_id})
    REFERENCES ${CustomerTable.name}(${CustomerColumns.id})
    ON DELETE CASCADE
  )

''';
}

abstract final class TagAssignmentColumns {
  static const tag_id = 'tag_id';
  static const from = 'starts_at';
  static const to = 'ends_at';
  static const customer_id = 'customer_id';
}

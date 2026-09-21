// ignore_for_file: constant_identifier_names, public_member_api_docs

import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class PriceAssignmentTable {
  static const name = TableNames.priceAssignment;

  static const create =
      '''
CREATE TABLE $name (
  ${PriceAssignmentColumns.customer_id} TEXT NOT NULL,
  ${PriceAssignmentColumns.from} TEXT NOT NULL,
  ${PriceAssignmentColumns.to}  TEXT,
  ${PriceAssignmentColumns.price} INT,
  PRIMARY KEY (${PriceAssignmentColumns.customer_id}, 
  ${PriceAssignmentColumns.from}),
    FOREIGN KEY(${PriceAssignmentColumns.customer_id})
    REFERENCES ${CustomerTable.name}(${CustomerColumns.id})
    ON DELETE CASCADE
  )
''';
}

abstract final class PriceAssignmentColumns {
  static const customer_id = 'customer_id';
  static const from = 'starts_at';
  static const to = 'ends_at';
  static const price = 'price';
}

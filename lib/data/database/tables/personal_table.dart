// ignore_for_file: constant_identifier_names, public_member_api_docs

import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class PersonalTable {
  static const name = TableNames.personal;
  static const create =
      '''
  CREATE TABLE $name (
  ${PersonalColumns.customer_id} TEXT NOT NULL,
  ${PersonalColumns.gender} INT,
  ${PersonalColumns.title}  TEXT,
  ${PersonalColumns.prename}  TEXT,
  ${PersonalColumns.surname} TEXT,
  PRIMARY KEY (${PersonalColumns.customer_id}),
    FOREIGN KEY(${PersonalColumns.customer_id})
    REFERENCES ${CustomerTable.name}(${CustomerColumns.id})
    ON DELETE CASCADE 
  )
''';
}

abstract final class PersonalColumns {
  static const customer_id = 'customer_id';
  static const gender = 'gender';
  static const title = 'title';
  static const prename = 'prename';
  static const surname = 'surname';
}

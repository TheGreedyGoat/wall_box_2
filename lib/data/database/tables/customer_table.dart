import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class CustomerTable {
  static const name = TableNames.customer;

  static const String create =
      '''
CREATE TABLE $name(
  ${CustomerColumns.id} TEXT NOT NULL,
  ${CustomerColumns.taxID} TEXT,
  PRIMARY KEY (${CustomerColumns.id})
)
''';
}

abstract final class CustomerColumns {
  static const id = 'id';
  static const taxID = 'taxID';
}

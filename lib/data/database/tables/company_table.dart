// ignore_for_file: constant_identifier_names, public_member_api_docs

import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class CompanyTable {
  static const name = TableNames.company;

  static const create =
      '''
    CREATE TABLE $name(
      ${CompanyColumns.customer_id} TEXT NOT NULL,
      ${CompanyColumns.company_name} TEXT NOT NULL, 
      ${CompanyColumns.company_addition} TEXT,
      PRIMARY KEY (${CompanyColumns.customer_id}),
      FOREIGN KEY(${CompanyColumns.customer_id})
      REFERENCES ${CustomerTable.name}(${CustomerColumns.id})
      ON DELETE CASCADE
    )
''';
}

abstract final class CompanyColumns {
  static const customer_id = 'customer_id';
  static const company_name = 'company_name';
  static const company_addition = 'company_addition';
}

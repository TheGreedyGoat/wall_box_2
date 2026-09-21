// ignore_for_file: constant_identifier_names, public_member_api_docs

import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class ContactTable {
  static const name = TableNames.contact;

  static const create =
      '''
  CREATE TABLE $name (
  ${ContactColumns.customer_id} TEXT NOT NULL,
  ${ContactColumns.phone} TEXT,
  ${ContactColumns.mobile}  TEXT,
  ${ContactColumns.fax} TEXT,
  ${ContactColumns.email} TEXT,
  ${ContactColumns.website} TEXT,
  PRIMARY KEY (${ContactColumns.customer_id}),
    FOREIGN KEY(${ContactColumns.customer_id})
    REFERENCES ${CustomerTable.name}(${CustomerColumns.id})
    ON DELETE CASCADE 
  )

''';
}

abstract final class ContactColumns {
  static const customer_id = 'customer_id';
  static const phone = 'phone';
  static const mobile = 'mobile';
  static const fax = 'fax';
  static const email = 'email';
  static const website = 'website';
}

import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class AddressTable {
  static const name = TableNames.address;

  static const create =
      '''
CREATE TABLE $name(
  ${AddressColumns.customer_id} TEXT NOT NULL,
  ${AddressColumns.street} TEXT,
  ${AddressColumns.house_number} TEXT,
  ${AddressColumns.adress_additions} TEXT,
  ${AddressColumns.postcode} TEXT,
  ${AddressColumns.city} TEXT,
  ${AddressColumns.state} TEXT,
  ${AddressColumns.country} TEXT,
  PRIMARY KEY (${AddressColumns.customer_id}),
  FOREIGN KEY(${AddressColumns.customer_id}) 
  REFERENCES ${CustomerTable.name}(${CustomerColumns.id}) 
  ON DELETE CASCADE
)
''';
}

abstract final class AddressColumns {
  static const customer_id = 'customer_id';
  static const street = 'street';
  static const house_number = 'house_number';
  static const adress_additions = 'adress_additions';
  static const postcode = 'postcode';
  static const city = 'city';
  static const state = 'state';
  static const country = 'country';
}

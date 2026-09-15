import 'package:wall_box_2/data/database/tables/table_names.dart';

abstract final class TransactionTable {
  static const name = TableNames.transaction;

  static const create =
      '''
  CREATE TABLE $name (
  ${TransactionColumns.id} TEXT NOT NULL,
  ${TransactionColumns.tag_id} TEXT NOT NULL,
  ${TransactionColumns.device_id} TEXT NOT NULL,
  ${TransactionColumns.start}  TEXT NOT NULL,
  ${TransactionColumns.stop}  TEXT NOT NULL,
  ${TransactionColumns.power_usage}  INT NOT NULL,
  ${TransactionColumns.discount}  INT,
  PRIMARY KEY (${TransactionColumns.id})
  )
''';
}

abstract final class TransactionColumns {
  static const id = 'id';
  static const tag_id = 'tag_id';
  static const device_id = 'device_id';
  static const start = 'start';
  static const stop = 'stop';
  static const power_usage = 'power_usage';
  static const discount = 'discount';
}

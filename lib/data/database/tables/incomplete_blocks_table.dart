// ignore_for_file: constant_identifier_names, public_member_api_docs

abstract class IncompleteBlocksTable {
  static const tableName = 'incomplete_blocks';
  static const create =
      '''
  CREATE TABLE $tableName(
    ${IncompleteBlocksColumns.source} TEXT NOT NULL,
    ${IncompleteBlocksColumns.device_id} TEXT NOT NULL,
    PRIMARY KEY(${IncompleteBlocksColumns.source})
  )
''';
}

abstract class IncompleteBlocksColumns {
  static const source = 'source';
  static const device_id = 'device_id';
}

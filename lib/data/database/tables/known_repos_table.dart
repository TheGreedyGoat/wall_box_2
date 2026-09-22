abstract class KnownLogsTable {
  static const name = 'known_logs';

  static const create =
      '''
      CREATE TABLE ${KnownLogsTable.name}(
        ${KnownLogsColumns.head} TEXT NOT NULL,
        PRIMARY KEY (${KnownLogsColumns.head})
      )
      ''';
}

abstract class KnownLogsColumns {
  static const head = 'head';
}

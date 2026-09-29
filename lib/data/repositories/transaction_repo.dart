import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/tables/transaction_table.dart';
import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

/// Saves all successfully scanned Transactions
class TransactionRepo extends Repository<Transaction> {
  /// Saves all successfully scanned Transactions
  TransactionRepo({required super.onchanged})
    : super(
        primaryKeyColumns: [TransactionColumns.id],
      );

  @override
  TransactionJsonConverter get converter => TransactionJsonConverter();

  @override
  String get tableName => TableNames.transaction;

  /// get a list of all distinct tagIDs
  Future<List<String>> get tagIds async {
    final qu = await query(
      distinct: true,
      columns: [TransactionColumns.tag_id],
    );
    return qu
        .map((json) => json[TransactionColumns.tag_id].toString())
        .toList();
  }
}

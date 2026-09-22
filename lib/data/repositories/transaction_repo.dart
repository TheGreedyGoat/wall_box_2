import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/tables/transaction_table.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

///
class TransactionRepo extends Repository<Transaction> {
  ///
  TransactionRepo({required super.onchanged});

  @override
  TransactionJsonConverter get converter => TransactionJsonConverter();

  @override
  String get tableName => TableNames.transaction;

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

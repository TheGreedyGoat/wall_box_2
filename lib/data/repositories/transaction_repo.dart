import 'package:json_annotation/src/json_converter.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

class TransactionRepo extends Repository<Transaction> {
  @override
  TransactionJsonConverter get converter => TransactionJsonConverter();

  @override
  String get tableName => TableNames.transaction;
}

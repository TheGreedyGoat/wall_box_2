import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

part 'transaction_page_state.freezed.dart';

@freezed
class TransactionPageState with _$TransactionPageState {
  final List<Transaction> transactions;

  const TransactionPageState({required this.transactions});
}

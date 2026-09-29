import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

part 'transaction_page_state.freezed.dart';

/// Contains wich transactions are loaded atm
@freezed
class TransactionPageState with _$TransactionPageState {
  @override
  /// The loaded transactions
  final List<Transaction> transactions;

  /// Contains wich transactions are loaded atm
  const TransactionPageState({required this.transactions});
}

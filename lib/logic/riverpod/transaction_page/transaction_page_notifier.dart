import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/riverpod/transaction_page/transaction_page_state.dart';

/// Keeps track of transactions saved in the database. The list is wrapped in a state class to make addition of future logic and information easier
class TransactionPageNotifier extends Notifier<TransactionPageState> {
  @override
  TransactionPageState build() => TransactionPageState(transactions: []);

  /// fetch transaction data from the repo
  void load() async {
    final transactions = await ref.watch(transactionRepoProvider).allRows;
    state = state.copyWith(
      transactions: transactions,
    );
  }
}

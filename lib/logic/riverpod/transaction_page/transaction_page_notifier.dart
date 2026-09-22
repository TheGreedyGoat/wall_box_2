import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/riverpod/transaction_page/transaction_page_state.dart';

class TransactionPageNotifier extends Notifier<TransactionPageState> {
  @override
  TransactionPageState build() => TransactionPageState(transactions: []);

  void load() async {
    final transactions = await ref.watch(transactionRepoProvider).allRows;
    state = state.copyWith(
      transactions: transactions,
    );
  }
}

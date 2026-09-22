import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/transaction_tile.dart';

class TransactionsTableCard extends ConsumerStatefulWidget {
  const TransactionsTableCard({super.key});

  @override
  ConsumerState<TransactionsTableCard> createState() =>
      _TransactionsTableCardState();
}

class _TransactionsTableCardState extends ConsumerState<TransactionsTableCard> {
  @override
  Widget build(BuildContext context) {
    final transactionFutures = ref.watch(transactionDataPackageProvider.future);
    return Card(
      child: FutureBuilder(
        future: transactionFutures,
        builder: (context, snapshot) {
          final transactions = snapshot.data ?? [];
          return ListView(
            children: [
              for (final transaction in transactions)
                TransactionTile(data: transaction),
            ],
          );
        },
      ),
    );
  }
}

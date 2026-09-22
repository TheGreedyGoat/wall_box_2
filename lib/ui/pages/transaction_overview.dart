import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/transaction_head_card.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/transactions_table_card.dart';

class PageTransactionOverview extends StatelessWidget {
  const PageTransactionOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 100, child: TransactionHeadCard()),
          Expanded(child: TransactionsTableCard()),
        ],
      ),
    );
  }
}

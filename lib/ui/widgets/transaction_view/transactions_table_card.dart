import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_master_data.dart';
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
    final customerData = ref.watch(selectedCustomerDataProvider);
    return Card(
      child: FutureBuilder(
        future: transactionFutures,
        builder: (context, snapshot) {
          final transactions =
              snapshot.data
                  ?.where(
                    (taPack) =>
                        customerData == null ||
                        taPack.customerData == customerData,
                  )
                  .toList() ??
              [];
          // sort by Customer first (putting unknown at the end)
          //and then by start date
          transactions.sort(
            (a, b) {
              final aIsUnknown = a.customerData == CustomerDataPackage.unknown;
              final bIsUnknown = b.customerData == CustomerDataPackage.unknown;
              int byCustomer = 0;
              if (aIsUnknown == bIsUnknown) {
                byCustomer = a.customerName.compareTo(b.customerName);
              } else if (aIsUnknown) {
                return 1;
              } else if (bIsUnknown) {
                return -1;
              }
              return byCustomer != 0
                  ? byCustomer
                  : a.transaction.start.compareTo(b.transaction.start);
            },
          );

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

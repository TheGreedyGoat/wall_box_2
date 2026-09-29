import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/predecorated/background_card.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/transaction_tile.dart';

/// Displays transactions from the database
class TransactionsTable extends ConsumerStatefulWidget {
  /// Displays transactions from the database
  const TransactionsTable({super.key});

  @override
  ConsumerState<TransactionsTable> createState() =>
      _TransactionsTableCardState();
}

class _TransactionsTableCardState extends ConsumerState<TransactionsTable> {
  @override
  Widget build(BuildContext context) {
    final transactionFutures = ref.watch(transactionDataPackageProvider.future);
    final customerData = ref.watch(selectedCustomerDataProvider);
    return BackgroundCard(
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

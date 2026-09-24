import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wall_box_2/ui/pages/split_page.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/import_file_button.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/transactions_customer_tile.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/transactions_table_card.dart';

class PageTransactionOverview extends StatelessWidget {
  const PageTransactionOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return SplitPage(
      left: CustomerOverview(
        appBarTitle: Text('Kunden'),
        appBarActions: [ImportFileButton()],
        widgetBuilder: (customerData) =>
            TransactionsCustomerTile(customerData: customerData),
        noCustomerWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Keine Kunden gespeichert'),
          ],
        ),
        showUnknown: true,
      ),
      right: TransactionsTableCard(),
    );
  }
}

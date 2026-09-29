import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/pages/split_page.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/import_file_button.dart';
import 'package:wall_box_2/ui/pages/content_pages/transactions_table.dart';

class PageTransactionOverview extends ConsumerWidget {
  const PageTransactionOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SplitPage(
      left: CustomerOverview(
        appBarTitle: Text('Kunden'),
        appBarActions: [ImportFileButton()],

        noCustomerWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Keine Kunden gespeichert'),
          ],
        ),
        showUnknown: true,
        onTileTap: (CustomerDataPackage data) {
          bool isSelected = ref.watch(selectedCustomerDataProvider) == data;
          ref.read(selectedCustomerDataProvider.notifier).data = isSelected
              ? null
              : data;
        },
        actionsBuilder: (CustomerDataPackage package) => [],
      ),
      right: TransactionsTable(),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/pages/content_pages/customer_bills.dart';
import 'package:wall_box_2/ui/pages/split_page.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview.dart';

class PageBills extends ConsumerStatefulWidget {
  const PageBills({super.key});

  @override
  ConsumerState<PageBills> createState() => _PageBillsState();
}

class _PageBillsState extends ConsumerState<PageBills> {
  @override
  Widget build(BuildContext context) {
    return SplitPage(
      left: CustomerOverview(
        noCustomerWidget: Text('Keine Kunden gespeichert'),
        onTileTap: (data) {
          ref.read(selectedCustomerDataProvider.notifier).data = data;
        },
        actionsBuilder: (package) => [],
      ),
      right: CustomerBills(),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/pages/split_page.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview_tile.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/enter_customer_data.dart';

/// Main page for the customer view
class PageCustomerDetails extends ConsumerWidget {
  /// Main page for the customer view
  const PageCustomerDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SplitPage(
      left: CustomerOverview(
        appBarTitle: Text('Kundenübersicht'),
        appBarActions: [
          IconButton(
            onPressed: () {
              ref.read(customerEditProvider.notifier).load(null);
            },
            icon: Icon(Icons.person_add),
            tooltip: 'Neuen Kunden anlegen',
          ),
        ],
        widgetBuilder: (data) => CustomerOverviewTile(data: data),
        noCustomerWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Keine Kunden gespeichert'),
          ],
        ),
      ),
      right: EnterCustomerData(),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/pages/enter_customer_data.dart';
import 'package:wall_box_2/ui/widgets/customer_overview_tile.dart';

class CustomerOverview extends ConsumerWidget {
  const CustomerOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapShot = ref.watch(customerPackageProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              toCustomerView(ref: ref, context: context);
            },
            child: Text('Kunden anlegen'),
          ),
        ],
      ),
      body: Center(
        child: snapShot.when(
          data: (data) => data.isEmpty
              ? noCustomers()
              : ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return CustomerOverviewTile(
                      data: data[index],
                    );
                  },
                ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget noCustomers() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Keine Kunden gespeichert'),
    ],
  );
}

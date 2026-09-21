import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/customer_overview_tile.dart';

/// displays a list of all known customers
class CustomerOverview extends ConsumerWidget {
  /// displays a list of all known customers
  const CustomerOverview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapShot = ref.watch(customerPackageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Kundenübersicht'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(customerEditProvider.notifier).load(null);
            },
            icon: Icon(Icons.person_add),
            tooltip: 'Neuen Kunden anlegen',
          ),
        ],
      ),
      body: Center(
        child: snapShot.when(
          data: (data) {
            data.sort((a, b) => a.displayName.compareTo(b.displayName));
            return data.isEmpty
                ? _noCustomers()
                : ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CustomerOverviewTile(
                        data: data[index],
                      );
                    },
                  );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _noCustomers() => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Keine Kunden gespeichert'),
    ],
  );
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview_tile.dart';

/// displays a list of all known customers
class CustomerOverview extends ConsumerWidget {
  final Widget Function(CustomerDataPackage data) widgetBuilder;
  final Widget noCustomerWidget;
  final Widget? appBarTitle;
  final List<Widget>? appBarActions;
  final bool showUnknown;

  /// displays a list of all known customers
  CustomerOverview({
    super.key,
    required this.widgetBuilder,
    required this.noCustomerWidget,
    this.appBarTitle,
    this.appBarActions,
    this.showUnknown = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapShot = ref.watch(customerPackageProvider);
    return Scaffold(
      appBar: AppBar(
        title: appBarTitle,
        actions: appBarActions,
      ),
      body: Center(
        child: snapShot.when(
          data: (customerDataList) {
            final copy = customerDataList.toList();
            copy.sort(
              (a, b) => a.displayName.compareTo(b.displayName),
            );
            if (showUnknown) {
              copy.add(CustomerDataPackage.unknown);
            }

            return copy.isEmpty
                ? noCustomerWidget
                : ListView(
                    children: [
                      ...copy.map(widgetBuilder),
                    ],
                  );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}

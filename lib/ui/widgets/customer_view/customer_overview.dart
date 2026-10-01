import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/customer_tiles/customer_tile.dart';
import 'package:wall_box_2/ui/widgets/predecorated/background_card.dart';

/// displays a list of all known customers
class CustomerOverview extends ConsumerWidget {
  // final Widget Function(CustomerDataPackage data) widgetBuilder;
  final Widget noCustomerWidget;
  final void Function(CustomerDataPackage data) onTileTap;
  final List<Widget> Function(CustomerDataPackage package) actionsBuilder;

  final Widget? appBarTitle;
  final List<Widget>? appBarActions;
  final bool showUnknown;

  /// displays a list of all known customers
  CustomerOverview({
    super.key,
    required this.noCustomerWidget,
    this.appBarTitle,
    this.appBarActions,
    this.showUnknown = false,
    required this.onTileTap,
    required this.actionsBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapShot = ref.watch(customerPackageProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   elevation: 10,
      //   title: appBarTitle,
      //   actions: appBarActions,
      // ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 100,
            child: BackgroundCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kunden'),
                  ...?appBarActions,
                ],
              ),
            ),
          ),
          Expanded(
            child: BackgroundCard(
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
                            ...copy.map(
                              (e) => CustomerTile(
                                customerData: e,
                                onTap: () {
                                  onTileTap(e);
                                },
                                actions: actionsBuilder(e),
                              ),
                            ),
                          ],
                        );
                },
                error: (error, stackTrace) => Text(error.toString()),
                loading: () => CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/confirm_action_dialog.dart';
import 'package:wall_box_2/ui/decorators/colors.dart';
import 'package:wall_box_2/ui/language/language.dart';

/// displays a customer's basic informations
///
/// clicking sets the main customer page to display [data]
class CustomerOverviewTile extends ConsumerWidget {
  /// The corresponding customer's data
  final CustomerDataPackage data;

  /// displays a customer's basic informations
  ///
  /// clicking sets the main customer page to display [data]
  const CustomerOverviewTile({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.watch(customerEditProvider) == data;
    return Card(
      color: AppColors(context).customerTileBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.0),
        side: isSelected ? BorderSide() : BorderSide.none,
      ),
      child: ListTile(
        onTap: () {
          ref.read(selectedCustomerDataProvider.notifier).data = data;
        },
        title: Text(
          data.displayName,
        ),
        subtitle: IntrinsicWidth(child: Text('# ${data.id}')),
      ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/colors.dart';

class TransactionsCustomerTile extends ConsumerWidget {
  final CustomerDataPackage customerData;
  const TransactionsCustomerTile({super.key, required this.customerData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.watch(selectedCustomerDataProvider) == customerData;
    return Card(
      color: AppColors(context).customerTileBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.0),
        side: isSelected ? BorderSide() : BorderSide.none,
      ),
      child: ListTile(
        onTap: () {},
        title: Text(customerData.displayName),
        subtitle: Text(customerData.id),
      ),
    );
  }
}

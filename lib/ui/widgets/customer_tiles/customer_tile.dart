import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/colors.dart';

class CustomerTile extends ConsumerWidget {
  final CustomerDataPackage customerData;
  final void Function()? onTap;
  final List<Widget>? actions;
  const CustomerTile({
    super.key,
    required this.customerData,
    this.onTap,
    this.actions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.watch(selectedCustomerDataProvider) == customerData;
    return Card(
      color: AppColors(context).getCustomerOuter(isSelected),
      child: Card(
        color: AppColors(context).customerTileBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(8.0),
          side: isSelected ? BorderSide() : BorderSide.none,
        ),
        child: ListTile(
          onTap: onTap,
          title: Text(customerData.displayName),
          subtitle: Text(customerData.id),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 2.0,
            children: actions ?? [],
          ),
        ),
      ),
    );
  }
}

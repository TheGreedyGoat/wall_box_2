import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview.dart';
import 'package:wall_box_2/ui/widgets/customer_view/enter_customer_data.dart';

/// Main page for the customer view
class CustomerPage extends ConsumerWidget {
  /// Main page for the customer view
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        SizedBox(
          width: 500,
          child: CustomerOverview(),
        ),
        Expanded(
          child: EnterCustomerData(),
        ),
      ],
    );
  }
}

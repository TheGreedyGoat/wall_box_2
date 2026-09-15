import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_generals.dart';

class EnterCustomerData extends ConsumerWidget {
  const EnterCustomerData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomerGenerals();
  }
}

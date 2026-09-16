import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_master_data.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/tag_assignments/tag_assigning.dart';

void toCustomerView({
  required WidgetRef ref,
  required BuildContext context,
  CustomerDataPackage? data,
}) {
  ref.read(customerEditProvider.notifier).set(data);
  if (data != null) {
    ref.read(tagAssignmenteditProvider.notifier).load(data.id);
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => _EnterCustomerData(
        original: data,
      ),
    ),
  );
}

class _EnterCustomerData extends ConsumerStatefulWidget {
  final CustomerDataPackage? original;
  const _EnterCustomerData({this.original, super.key});

  @override
  ConsumerState<_EnterCustomerData> createState() => _EnterCustomerDataState();
}

class _EnterCustomerDataState extends ConsumerState<_EnterCustomerData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        child: SingleChildScrollView(
          primary: true,
          scrollDirection: Axis.vertical,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1000),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomerMasterData(
                  original: widget.original,
                ),
                Text(currentLanguage.assignedTags),
                TagAssigning(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/data/interface_models/customer_data_package.dart';
import 'package:wall_box_2/logic/helpers/enums/genders.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/services/global.dart';

class CustomerGenerals extends ConsumerStatefulWidget {
  const CustomerGenerals({super.key});

  @override
  ConsumerState<CustomerGenerals> createState() => _CustomerGeneralsState();
}

class _CustomerGeneralsState extends ConsumerState<CustomerGenerals> {
  CustomerEditNotifier get notifier => ref.read(customerEditProvider.notifier);
  CustomerDataPackage get state => ref.watch(customerEditProvider);
  final TextEditingController idController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //cust_id
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: idController,
                    decoration: InputDecoration(label: Text('Kundenkennung')),
                    onChanged: (value) => notifier.setId(value),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    final id = generateId();
                    ref.read(customerEditProvider.notifier).setId(id);
                    idController.text = id;
                  },
                  child: Text('generieren'),
                ),
              ],
            ),
            TextField(
              decoration: InputDecoration(label: Text('Firma')),
            ),
            TextField(
              decoration: InputDecoration(label: Text('Firmenzusatz')),
            ),
            Row(
              children: [
                DropdownMenuFormField(
                  label: Text('Anrede'),
                  dropdownMenuEntries: [
                    ...Gender.values.map(
                      (e) => DropdownMenuEntry(value: e, label: e.toString()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

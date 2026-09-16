import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/services/global.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';

class CustomerID extends ConsumerStatefulWidget {
  final bool editable;
  const CustomerID({required this.editable, super.key});

  @override
  ConsumerState<CustomerID> createState() => _CustomerGeneralsState();
}

class _CustomerGeneralsState extends ConsumerState<CustomerID> {
  CustomerEditNotifier get notifier => ref.read(customerEditProvider.notifier);
  CustomerDataPackage get state => ref.watch(customerEditProvider);
  final TextEditingController idController = TextEditingController();

  @override
  void initState() {
    idController.text = state.id;
    super.initState();
  }

  @override
  void dispose() {
    idController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      spacing: 8.0,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //cust_id
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          children: [
            Expanded(
              child: TextFormField(
                readOnly: !widget.editable,
                controller: idController,
                decoration: textFieldDecoration.copyWith(
                  label: Text(currentLanguage.customerID),
                  errorText: ref
                      .watch(customerErrorProvider)
                      .getMessage(DataError.noID),
                ),
                onChanged: (value) => notifier.setId(value),
              ),
            ),
            if (widget.editable)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      final id = generateId();
                      ref.read(customerEditProvider.notifier).setId(id);
                      idController.text = id;
                    },
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                    child: Icon(Icons.refresh),
                  ),
                  Text(currentLanguage.generate),
                ],
              ),
          ],
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/logic/services/global.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';

/// Display the current customer's id.
///
/// Editable if a new customer is created
class CustomerIDField extends ConsumerStatefulWidget {
  /// Display the current customer's id.
  ///
  /// Editable if a new customer is created
  const CustomerIDField({super.key});

  @override
  ConsumerState<CustomerIDField> createState() => _CustomerGeneralsState();
}

class _CustomerGeneralsState extends ConsumerState<CustomerIDField> {
  CustomerEditNotifier get notifier => ref.read(customerEditProvider.notifier);
  CustomerEditState get state => ref.watch(customerEditProvider);
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

  @override
  Widget build(BuildContext context) {
    final errorState = ref.watch(customerErrorProvider);
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
                readOnly: !state.isCreation,
                controller: idController,
                decoration: textFieldDecoration.copyWith(
                  hoverColor: state.isCreation ? null : Colors.white,
                  label: Text(currentLanguage.customerID),
                  // fillColor: state.isCreation ? null : Colors.grey,
                  border: state.isCreation ? null : InputBorder.none,
                  errorText:
                      errorState.getMessage(DataError.noID) ??
                      errorState.getMessage(DataError.idTaken),
                ),
                onChanged: (value) => notifier.setId(value),
              ),
            ),
            if (state.isCreation)
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

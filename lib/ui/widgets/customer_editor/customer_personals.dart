import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/helpers/enums/genders.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';

class CustomerPersonals extends ConsumerStatefulWidget {
  const CustomerPersonals({super.key});

  @override
  ConsumerState<CustomerPersonals> createState() => _CustomerPersonalsState();
}

class _CustomerPersonalsState extends ConsumerState<CustomerPersonals> {
  CustomerEditNotifier get notifier => ref.read(customerEditProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerEditProvider);
    final errorState = ref.watch(customerErrorProvider);
    return Column(
      spacing: 8.0,
      children: [
        Row(
          spacing: 8.0,
          children: [
            DropdownMenuFormField(
              initialSelection: state.personal?.gender,
              label: Text(currentLanguage.salutation),
              dropdownMenuEntries: [
                ...Gender.values.map(
                  (e) => DropdownMenuEntry(value: e, label: e.titleDisplay),
                ),
              ],
              onSelected: (value) {
                notifier.updatePersonals(
                  changes: (companyData) => companyData.copyWith(gender: value),
                );
              },
            ),
            Expanded(
              child: TextFormField(
                initialValue: state.personal?.title,
                decoration: textFieldDecoration.copyWith(
                  label: Text(currentLanguage.title),
                ),
                onChanged: (value) => notifier.updatePersonals(
                  changes: (personalData) =>
                      personalData.copyWith(title: value),
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: state.personal?.prename,
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.prename),
          ),

          onChanged: (value) => notifier.updatePersonals(
            changes: (personalData) => personalData.copyWith(prename: value),
          ),
        ),
        TextFormField(
          initialValue: state.personal?.surname,
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.surname),
            errorText: errorState.getMessage(DataError.noCompanyOrPersonal),
          ),

          onChanged: (value) => notifier.updatePersonals(
            changes: (personalData) => personalData.copyWith(surname: value),
          ),
        ),
      ],
    );
  }
}

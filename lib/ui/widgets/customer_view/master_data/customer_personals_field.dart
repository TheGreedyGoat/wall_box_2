import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/helpers/enums/genders.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';

/// holds all fields to display and edit personal data
class CustomerPersonalsFields extends ConsumerStatefulWidget {
  /// holds all fields to display and edit personal data
  const CustomerPersonalsFields({super.key});

  @override
  ConsumerState<CustomerPersonalsFields> createState() =>
      _CustomerPersonalsState();
}

class _CustomerPersonalsState extends ConsumerState<CustomerPersonalsFields> {
  CustomerEditNotifier get notifier => ref.read(customerEditProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(customerEditProvider).data;
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
                  (e) => DropdownMenuEntry(value: e, label: e.display),
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

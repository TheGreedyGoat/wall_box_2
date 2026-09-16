import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_validation_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';

class CustomerCompany extends ConsumerStatefulWidget {
  const CustomerCompany({super.key});

  @override
  ConsumerState<CustomerCompany> createState() => _CustomerCompanyState();
}

class _CustomerCompanyState extends ConsumerState<CustomerCompany> {
  CustomerEditNotifier get notifier => ref.read(customerEditProvider.notifier);
  CustomerDataPackage get state => ref.watch(customerEditProvider);

  @override
  Widget build(BuildContext context) {
    final CustomerEditErrorState errorState = ref.watch(customerErrorProvider);
    return Column(
      spacing: 8.0,
      children: [
        TextFormField(
          initialValue: state.company?.companyName,
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.company),
            errorText: errorState.getMessage(DataError.noCompanyOrPersonal),
          ),
          onChanged: (value) {
            notifier.updateCompany(
              changes: (companyData) =>
                  companyData.copyWith(companyName: value),
            );
          },
        ),
        TextFormField(
          initialValue: state.company?.companyAddition,
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.companyAddition),
          ),
          onChanged: (value) => notifier.updateCompany(
            changes: (companyData) =>
                companyData.copyWith(companyAddition: value),
          ),
        ),
      ],
    );
  }
}

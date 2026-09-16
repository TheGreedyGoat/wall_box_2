import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_validation_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';

class CustomerAddress extends ConsumerStatefulWidget {
  const CustomerAddress({super.key});

  @override
  ConsumerState<CustomerAddress> createState() => _CustomerAddressState();
}

class _CustomerAddressState extends ConsumerState<CustomerAddress> {
  CustomerEditNotifier get notifier => ref.read(customerEditProvider.notifier);
  CustomerDataPackage get state => ref.watch(customerEditProvider);

  @override
  Widget build(BuildContext context) {
    CustomerEditErrorState errorState = ref.watch(customerErrorProvider);
    return Column(
      spacing: 8.0,
      children: [
        Row(
          spacing: 8.0,
          children: [
            Expanded(
              child: TextFormField(
                initialValue: state.address.street,
                decoration: textFieldDecoration.copyWith(
                  label: Text(currentLanguage.street),
                ),
                onChanged: (value) => notifier.updateAddress(
                  changes: (address) => address.copyWith(street: value),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextFormField(
                initialValue: state.address.number,
                decoration: textFieldDecoration.copyWith(
                  label: Text(currentLanguage.houseNumber),
                ),
                onChanged: (value) => notifier.updateAddress(
                  changes: (address) => address.copyWith(number: value),
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: state.address.addressAdditions,
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.addressAddition),
          ),
          onChanged: (value) => notifier.updateAddress(
            changes: (address) => address.copyWith(addressAdditions: value),
          ),
        ),
        Row(
          spacing: 8.0,
          children: [
            SizedBox(
              width: 100,
              child: TextFormField(
                initialValue: state.address.postcode,
                decoration: textFieldDecoration.copyWith(
                  label: Text(currentLanguage.postcode),
                ),
                onChanged: (value) => notifier.updateAddress(
                  changes: (address) => address.copyWith(postcode: value),
                ),
              ),
            ),
            Expanded(
              child: TextFormField(
                initialValue: state.address.city,
                decoration: textFieldDecoration.copyWith(
                  label: Text(currentLanguage.city),
                  errorText: errorState.getMessage(DataError.noCity),
                ),

                onChanged: (value) => notifier.updateAddress(
                  changes: (address) => address.copyWith(city: value),
                ),
              ),
            ),
          ],
        ),
        TextFormField(
          initialValue: state.address.country,
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.country),
            errorText: errorState.getMessage(DataError.noCountry),
          ),
          onChanged: (value) => notifier.updateAddress(
            changes: (address) => address.copyWith(country: value),
          ),
        ),
        TextFormField(
          initialValue: state.address.state,
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.state),
          ),
          onChanged: (value) => notifier.updateAddress(
            changes: (address) => address.copyWith(state: value),
          ),
        ),
      ],
    );
  }
}

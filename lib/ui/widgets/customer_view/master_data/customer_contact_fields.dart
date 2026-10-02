import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/contact/email.dart';
import 'package:wall_box_2/logic/models/master_data/contact/phone.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/widgets/general/text_form_fields/text_form_field_digits.dart';

/// Subwidget for a customer's page to display and edit contact data
class CustomerContactFields extends ConsumerWidget {
  /// Subwidget for a customer's page to display and edit address data
  const CustomerContactFields({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contact = ref.watch(customerEditProvider).contact;
    final errorState = ref.watch(customerErrorProvider);
    final editNotifier = ref.read(customerEditProvider.notifier);
    return Column(
      spacing: 8.0,
      children: [
        MyTextFormField<Email>(
          parser: (text) => text != null ? Email.new(data: text) : null,
          onChanged: (value) {
            if (value != null) {
              editNotifier.updateContact(
                changes: (contact) => contact.copyWith(email: value),
              );
            }
          },
          label: currentLanguage.email,
          errorText: errorState.getMessage(DataError.invalidEmail),
        ),
        TextFormField(
          initialValue: (contact?.phone ?? '').toString(),

          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.phone),
            errorText: errorState.getMessage(DataError.invalidPhone),
          ),
          onChanged: (value) {
            editNotifier.updateContact(
              changes: (contact) {
                return contact.copyWith(phone: Phone(data: value));
              },
            );
          },
        ),
        TextFormField(
          initialValue: (contact?.mobile ?? '').toString(),

          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.mobile),
          ),
          onChanged: (value) {
            editNotifier.updateContact(
              changes: (contact) =>
                  contact.copyWith(mobile: Phone(data: value)),
            );
          },
        ),
        TextFormField(
          initialValue: (contact?.fax ?? '').toString(),
          decoration: textFieldDecoration.copyWith(
            label: Text(currentLanguage.fax),
          ),
          onChanged: (value) {
            editNotifier.updateContact(
              changes: (contact) => contact.copyWith(fax: Phone(data: value)),
            );
          },
        ),
        MyTextFormField.text(
          initialValue: (contact?.website ?? ''),
          onChanged: (value) {
            editNotifier.updateContact(
              changes: (contact) => contact.copyWith(website: value),
            );
          },
          label: currentLanguage.website,
        ),
        // TextFormField(
        //   initialValue: (contact?.website ?? ''),
        //   decoration: textFieldDecoration.copyWith(
        //     label: Text(currentLanguage.website),
        //   ),
        //   onChanged: (value) {
        //     editNotifier.updateContact(
        //       changes: (contact) => contact.copyWith(website: value),
        //     );
        //   },
        // ),
      ],
    );
  }
}

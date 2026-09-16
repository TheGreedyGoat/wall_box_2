import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_address.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_company.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_contact.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_id.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_personals.dart';

class CustomerMasterData extends ConsumerStatefulWidget {
  final CustomerDataPackage? original;

  const CustomerMasterData({this.original, super.key});

  @override
  ConsumerState<CustomerMasterData> createState() => _CustomerMasterDataState();
}

class _CustomerMasterDataState extends ConsumerState<CustomerMasterData> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 8.0,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      if (!_validate()) return;
                      _save();
                    },
                    child: Row(
                      spacing: 4.0,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.save),
                        Text(currentLanguage.save),
                      ],
                    ),
                  ),
                  //DISCARD
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                    },
                    child: Row(
                      spacing: 4.0,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.undo),
                        Text(currentLanguage.discard),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: Row(
                  spacing: 32.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 20.0,
                        children: [
                          CustomerID(
                            editable: (widget.original?.id ?? '').isEmpty,
                          ),
                          CustomerCompany(),
                          CustomerPersonals(),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        spacing: 20.0,
                        children: [
                          CustomerAddress(),
                          CustomerContact(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _validate() {
    return ref.read(customerErrorProvider.notifier).validate().errors.isEmpty;
  }

  void _save() {
    ref
        .read(customerEditProvider.notifier)
        .save(
          onSuccess: () => _snackBar(
            context,
            currentLanguage.saveSuccessful,
          ),
          onError: (p0) {
            print(p0.toString());
            _snackBar(
              context,
              currentLanguage.errorOccured,
            );
          },
        );
  }

  void _snackBar(BuildContext context, String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

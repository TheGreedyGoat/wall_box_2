import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_master_data.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/tag_assignments/customer_tag_assignments.dart';

/// Prepares data for the customer editing page and navigates to it.
/// set data = null to create a new customer
///
void toCustomerView({
  required WidgetRef ref,
  required BuildContext context,
  CustomerDataPackage? data,
}) {
  _loadCustomerEditData(ref, data);
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => _EnterCustomerData(
        original: data,
      ),
    ),
  );
}

/// triggers all relevant notifiers to fetch the data they need corresponding to the customer
///
/// All values on the page will change to match, what is currently saved in the database or to be empty if no data package is passed
void _loadCustomerEditData(WidgetRef ref, CustomerDataPackage? data) {
  ref.read(customerEditProvider.notifier).load(data?.id);
  ref.read(tagAssignmenteditProvider.notifier).load(data?.id);
  ref.read(priceAssignmentEditProvider.notifier).load(data?.id);
  ref.read(customerEditChangeProvider.notifier).set(false);
}

/// The core page to create or edit customer data.
///
/// This is set private to ensure all access is made through [toCustomerView]. This way we guarantee everything gets setup properly
class _EnterCustomerData extends ConsumerStatefulWidget {
  final CustomerDataPackage? original;
  const _EnterCustomerData({this.original});

  @override
  ConsumerState<_EnterCustomerData> createState() => _EnterCustomerDataState();
}

class _EnterCustomerDataState extends ConsumerState<_EnterCustomerData> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final activeChanges = ref.watch(customerEditChangeProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (activeChanges) _headRow(),
            Scrollbar(
              thumbVisibility: true,
              trackVisibility: true,
              child: SingleChildScrollView(
                primary: true,
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  height: 650,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomerMasterData(
                        original: widget.original,
                      ),
                      CustomerTagAssignments(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _headRow() => Card(
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
              _loadCustomerEditData(ref, widget.original);
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
  );

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

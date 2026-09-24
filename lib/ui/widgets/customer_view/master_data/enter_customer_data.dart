import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_master_data.dart';
import 'package:wall_box_2/ui/widgets/customer_view/tag_assignments/customer_tag_assignments.dart';

/// triggers all relevant notifiers to fetch the data they need corresponding to the customer
///
/// All values on the page will change to match, what is currently saved in the database or to be empty if no data package is passed
void _loadCustomerEditData(WidgetRef ref, CustomerDataPackage? data) {
  ref.read(customerEditProvider.notifier).load(data?.id);
}

/// The core page to create or edit customer data.
class EnterCustomerData extends ConsumerStatefulWidget {
  /// The core page to create or edit customer data.
  const EnterCustomerData({super.key});

  @override
  ConsumerState<EnterCustomerData> createState() => _EnterCustomerDataState();
}

class _EnterCustomerDataState extends ConsumerState<EnterCustomerData> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final customerState = ref.watch(customerEditProvider);
    final activeChanges = ref.watch(customerEditChangeProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (customerState.original?.id.trim() ?? '').isEmpty
              ? 'Neuer Kunde'
              : customerState.data.displayName,
        ),
      ),
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
                        key: ValueKey(customerState.original),
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
              _validateAndTrySave();
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
              ref.read(customerEditProvider.notifier).reload();
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

  void _validateAndTrySave() {
    ref
        .read(customerEditProvider.notifier)
        .validateAndTrySave(
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

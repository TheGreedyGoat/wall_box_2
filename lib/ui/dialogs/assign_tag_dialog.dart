import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/general/date_button.dart';

Future<void> showAssignmentDialog(
  BuildContext context,
  String tagID, {
  DateTime? initialDate,
}) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      child: SizedBox(
        width: 500,
        height: 500,
        child: AssignTagDialog(
          tagID: tagID,
          initialDate: initialDate,
        ),
      ),
    ),
  );
}

class AssignTagDialog extends ConsumerStatefulWidget {
  final String tagID;
  final DateTime? initialDate;
  const AssignTagDialog({super.key, required this.tagID, this.initialDate});

  @override
  ConsumerState<AssignTagDialog> createState() => _AssignTagDialogState();
}

class _AssignTagDialogState extends ConsumerState<AssignTagDialog> {
  late DateTime earliest;
  late DateTime? selectedStartDate;
  CustomerDataPackage? selectedCustomer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final earliestDate = await ref
            .read(tagAssignmentRepoProvider)
            .earliestAvailableDate(widget.tagID);
        setState(() {
          earliest =
              earliestDate ?? DateTime.now().subtract(Duration(days: 365));
          selectedStartDate = widget.initialDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final customersFut = ref.read(customerPackageProvider.future);
    return FutureBuilder(
      future: customersFut,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final customers = snapshot.requireData;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tag ${widget.tagID} zuweisen',
                style: TextStyle(fontSize: 30),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsetsDirectional.symmetric(vertical: 16),
                        children: [
                          ...customers.map(
                            (cust) => Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  8.0,
                                ),
                                side: selectedCustomer == cust
                                    ? BorderSide()
                                    : BorderSide.none,
                              ),
                              child: ListTile(
                                onTap: () {
                                  setState(() {
                                    selectedCustomer = cust;
                                  });
                                },
                                title: Text(cust.displayName),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: CalendarDatePicker(
                        firstDate: earliest,
                        lastDate: DateTime.now(),
                        initialDate:
                            !(widget.initialDate?.isBefore(earliest) ?? true)
                            ? widget.initialDate
                            : DateTime.now(),
                        onDateChanged: (DateTime value) {
                          setState(() {
                            selectedStartDate = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 8.0,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('abbrechen'),
                  ),
                  TextButton(
                    onPressed: selectedCustomer != null
                        ? () {
                            final newAssignment = TagAssignment(
                              tagID: widget.tagID,
                              customerID: selectedCustomer!.id,
                              from: selectedStartDate!,
                            );

                            ref
                                .read(tagAssignmentRepoProvider)
                                .insert(newAssignment);

                            Navigator.pop(context);
                          }
                        : null,
                    child: Text('übernehmen'),
                  ),
                ],
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('Error');
        }
        return CircularProgressIndicator();
      },
    );
  }
}

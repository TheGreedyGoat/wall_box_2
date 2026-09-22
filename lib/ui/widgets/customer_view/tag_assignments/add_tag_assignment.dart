// ignore_for_file: use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';
import 'package:wall_box_2/logic/helpers/enums/assignment_error.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';

/// Widget to add a new tag assignment to a customer
///
///
class AddTagAssignment extends ConsumerStatefulWidget {
  /// Widget to add a new tag assignment to a customer
  ///
  ///
  const AddTagAssignment({super.key});

  @override
  ConsumerState<AddTagAssignment> createState() => _AddTagAssignmentState();
}

class _AddTagAssignmentState extends ConsumerState<AddTagAssignment> {
  DateTime? currentFromDate;
  final TextEditingController _tagIDController = TextEditingController();

  String get tagID => _tagIDController.text;
  set tagID(String value) => _tagIDController.text = value;

  List<TagAssignmentError> errors = [];

  bool get noDate =>
      errors.contains(TagAssignmentError.noStartDate) &&
      currentFromDate == null;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          TextFormField(
            controller: _tagIDController,
            decoration: textFieldDecoration.copyWith(
              labelText: 'Tag-ID',
              errorText: errors.contains(TagAssignmentError.noTagID)
                  ? 'erforderlich'
                  : errors.contains(TagAssignmentError.tagIDTaken)
                  ? 'TagID ist bereits zugewiesen'
                  : null,
            ),
          ),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: noDate
                  ? Theme.of(context).colorScheme.error
                  : null,
            ),
            onPressed: () {
              _pickDate();
            },
            child: Text(currentFromDate?.toDateOnlyString() ?? 'DD.MM.YYYY'),
          ),
          if (noDate)
            Text(
              'Kein Startdatum zugewiesen',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          IconButton(
            onPressed: () async {
              final validation = await validateAssignment();
              if (validation.isEmpty) {
                ref
                    .read(tagAssignmenteditProvider.notifier)
                    .addAssignment(
                      TagAssignment(
                        tagID: _tagIDController.text,
                        customerID: ref.read(customerEditProvider).id,
                        from: currentFromDate!,
                      ),
                      () {},
                    );
                _clearInput();
              }
              setState(() {
                errors = validation;
              });
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }

  void _clearInput() {
    setState(() {
      tagID = '';
      currentFromDate = null;
    });
  }

  void _pickDate() async {
    if (!context.mounted) return;
    final date = await showDatePicker(
      context: context,
      firstDate:
          await ref
              .read(tagAssignmentRepoProvider)
              .earliestAvailableDate(tagID) ??
          DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
    );
    setState(() {
      currentFromDate = date;
    });
  }

  Future<List<TagAssignmentError>> validateAssignment() async {
    return [
      if (currentFromDate == null) TagAssignmentError.noStartDate,
      if ((tagID.trim()).isEmpty) TagAssignmentError.noTagID,
      if ((tagID.trim()).isNotEmpty &&
          !(await ref.read(tagAssignmentRepoProvider).isAvailable(tagID)))
        TagAssignmentError.tagIDTaken,
    ];
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/customer_price_display.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/tag_assignments/add_tag_assignment.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/tag_assignments/tag_assignment_tile.dart';

class CustomerTagAssignments extends ConsumerStatefulWidget {
  const CustomerTagAssignments({super.key});

  @override
  ConsumerState<CustomerTagAssignments> createState() => _TagAssigningState();
}

class _TagAssigningState extends ConsumerState<CustomerTagAssignments> {
  bool hideOld = false;
  @override
  Widget build(BuildContext context) {
    final assignmentState = ref.watch(tagAssignmenteditProvider);
    return SizedBox(
      width: 600,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              spacing: 4.0,
              children: [
                Checkbox(
                  value: hideOld,
                  onChanged: (value) {
                    setState(() {
                      hideOld = value!;
                    });
                  },
                ),
                Text('abgeschlossene verstecken'),
              ],
            ),

            SizedBox(
              height: 390,
              child: _newAssignmentDisplay(),
            ),
            const AddTagAssignment(),
            CustomerPriceDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _newAssignmentDisplay() {
    final assignmentState = ref.watch(tagAssignmenteditProvider);
    var unmodified = assignmentState.unmodified;
    if (hideOld) {
      unmodified = unmodified
          .where(
            (element) => element.to == null,
          )
          .toList();
    }
    final modified = assignmentState.modified;
    final added = assignmentState.added;
    final removed = assignmentState.removed;
    return ListView(
      children: [
        ...modified.map(
          (e) => TagAssignmentTile(
            assignment: e,
            assignmentState: TagAssignmentState.modified,
          ),
        ),
        ...added.map(
          (e) => TagAssignmentTile(
            assignment: e,
            assignmentState: TagAssignmentState.added,
          ),
        ),
        ...unmodified.map(
          (e) => TagAssignmentTile(
            assignment: e,
            assignmentState: TagAssignmentState.unmodified,
          ),
        ),
        ...removed.map(
          (e) => TagAssignmentTile(
            assignment: e,
            assignmentState: TagAssignmentState.removed,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/enums/data_modification_type.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_price_display.dart';
import 'package:wall_box_2/ui/widgets/customer_view/tag_assignments/add_tag_assignment.dart';
import 'package:wall_box_2/ui/widgets/customer_view/tag_assignments/tag_assignment_tile.dart';

/// widget to edit a customer's tag assignments
///
/// The user can add new assignments, set end dates for unfinished assignements and delete already existing ones
///
class CustomerTagAssignments extends ConsumerStatefulWidget {
  /// widget to edit a customer's tag assignments
  ///
  /// The user can add new assignments, set end dates for unfinished assignements and delete already existing ones
  ///
  const CustomerTagAssignments({super.key});

  @override
  ConsumerState<CustomerTagAssignments> createState() => _TagAssigningState();
}

class _TagAssigningState extends ConsumerState<CustomerTagAssignments> {
  bool hideOld = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                IconButton(
                  onPressed: () {
                    ref.read(tagAssignmenteditProvider.notifier).revertAll();
                  },
                  tooltip: 'Tag - Änderungen rückgängig machen',
                  icon: Icon(Icons.undo),
                ),
              ],
            ),

            SizedBox(
              height: 390,
              child: _tagAssignmentDisplay(),
            ),
            const AddTagAssignment(),
            CustomerPriceDisplay(),
          ],
        ),
      ),
    );
  }

  Widget _tagAssignmentDisplay() {
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
            key: ValueKey(
              '${e.change!.tagID}_${e.change!.from.toIso8601String()}',
            ),
            assignment: e.change!,
            modification: DataModificationType.modified,
          ),
        ),
        ...added.map(
          (e) => TagAssignmentTile(
            key: ValueKey(
              '${e.tagID}_${e.from.toIso8601String()}',
            ),
            assignment: e,
            modification: DataModificationType.added,
          ),
        ),
        ...unmodified.map(
          (e) => TagAssignmentTile(
            key: ValueKey(
              '${e.tagID}_${e.from.toIso8601String()}',
            ),
            assignment: e,
            modification: DataModificationType.unmodified,
          ),
        ),
        ...removed.map(
          (e) => TagAssignmentTile(
            key: ValueKey(
              '${e.tagID}_${e.from.toIso8601String()}',
            ),
            assignment: e,
            modification: DataModificationType.removed,
          ),
        ),
      ],
    );
  }
}

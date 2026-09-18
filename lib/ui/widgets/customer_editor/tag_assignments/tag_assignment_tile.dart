import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/general/date_button.dart';

enum TagAssignmentState {
  unmodified,
  modified,
  removed,
  added;

  Color color(BuildContext context) => switch (this) {
    TagAssignmentState.unmodified => Theme.of(context).colorScheme.surfaceDim,
    TagAssignmentState.modified => Colors.deepOrangeAccent,
    TagAssignmentState.removed => Colors.blueGrey,
    TagAssignmentState.added => Colors.lightGreen,
  };
}

/// displays one TagAssignment
class TagAssignmentTile extends ConsumerWidget {
  /// You'll figure it out
  final TagAssignment assignment;
  final TagAssignmentState assignmentState;

  /// displays one TagAssignment
  const TagAssignmentTile({
    super.key,
    required this.assignment,
    this.assignmentState = TagAssignmentState.unmodified,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: assignmentState.color(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          height: 35,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 150,
                child: Container(
                  // color: Colors.blueGrey,
                  child: SelectableText(
                    '${assignment.tagID}',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),

              SelectableText(assignment.from.toNiceString()),
              assignment.to != null
                  ? SelectableText(
                      assignment.to!.toNiceString(),
                    )
                  : DateButton(
                      firstDate: assignment.from.add(Duration(days: 1)),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                      onSelected: (date) {
                        ref
                            .read(tagAssignmenteditProvider.notifier)
                            .setAssignmentEnd(assignment.tagID, date);
                      },
                      enabled: assignmentState != TagAssignmentState.removed,
                      notSelectedLabel: 'aktuell',
                    ),

              SizedBox(
                child: IconButton(
                  onPressed: () {
                    final notifier = ref.read(
                      tagAssignmenteditProvider.notifier,
                    );
                    assignmentState == TagAssignmentState.unmodified
                        ? notifier.setDeletion(assignment.tagID)
                        : notifier.revertChange(assignment.tagID);
                  },
                  icon: assignmentState == TagAssignmentState.unmodified
                      ? Icon(Icons.cancel)
                      : Icon(Icons.undo),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

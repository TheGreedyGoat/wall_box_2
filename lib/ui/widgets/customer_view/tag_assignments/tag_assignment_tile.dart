import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';
import 'package:wall_box_2/logic/helpers/enums/data_modification_type.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/general/date_button.dart';

/// displays one TagAssignment
class TagAssignmentTile extends ConsumerWidget {
  /// You'll figure it out
  final TagAssignment assignment;

  /// If and how the qassignment was changed
  final DataModificationType modification;

  /// displays one TagAssignment
  const TagAssignmentTile({
    required super.key,
    required this.assignment,
    this.modification = DataModificationType.unmodified,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: modification.color(context),
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
                child: SelectableText(
                  '${assignment.tagID}',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              SelectableText(assignment.from.toDateOnlyString()),
              assignment.to != null
                  ? SelectableText(
                      assignment.to!.toDateOnlyString(),
                    )
                  : DateButton(
                      firstDate: assignment.from.add(Duration(days: 1)),
                      lastDate: DateTime.now().add(Duration(days: 365)),
                      onSelected: (date) {
                        ref
                            .read(tagAssignmenteditProvider.notifier)
                            .setAssignmentEnd(
                              assignment.tagID,
                              assignment.from,
                              date,
                            );
                      },
                      enabled: modification != DataModificationType.removed,
                      notSelectedLabel: 'aktuell',
                    ),

              SizedBox(
                child: IconButton(
                  onPressed: () {
                    final notifier = ref.read(
                      tagAssignmenteditProvider.notifier,
                    );
                    modification == DataModificationType.unmodified
                        ? notifier.setDeletion(
                            assignment.tagID,
                            assignment.from,
                          )
                        : notifier.revertChange(assignment.tagID);
                  },
                  icon: modification == DataModificationType.unmodified
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

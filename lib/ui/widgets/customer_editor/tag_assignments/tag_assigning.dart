import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/tag_assignments/add_assignment.dart';
import 'package:wall_box_2/ui/widgets/customer_editor/tag_assignments/tag_assignment_tile.dart';

class TagAssigning extends ConsumerStatefulWidget {
  const TagAssigning({super.key});

  @override
  ConsumerState<TagAssigning> createState() => _TagAssigningState();
}

class _TagAssigningState extends ConsumerState<TagAssigning> {
  bool showOld = false;
  @override
  Widget build(BuildContext context) {
    final assignmentState = ref.watch(tagAssignmenteditProvider);
    return Card(
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
                value: showOld,
                onChanged: (value) {
                  setState(() {
                    showOld = value!;
                  });
                },
              ),
              Text('vergangene anzeigen'),
            ],
          ),
          Card(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: ListTile(
                    title: Text('Tag-ID'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('zugewiesen von'),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text('bis'),
                  ),
                ),
              ],
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 500),
            child: _assignmentDisplay(assignmentState.full),
          ),
          AddTagAssignment(),
        ],
      ),
    );
  }

  Widget _assignmentDisplay(List<TagAssignment> assignments) {
    final list = showOld
        ? assignments
        : assignments
              .where(
                (element) => element.to == null,
              )
              .toList();
    return list.isEmpty
        ? Text('Keine Zuweisungen gefunden')
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return TagAssignmentTile(assignment: list[index]);
            },
          );
  }
}

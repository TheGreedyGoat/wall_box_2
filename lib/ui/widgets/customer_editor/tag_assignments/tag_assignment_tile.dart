import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/ui/language/language.dart';

class TagAssignmentTile extends StatelessWidget {
  final TagAssignment assignment;
  const TagAssignmentTile({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListTile(
              title: SelectableText('# ${assignment.tagID}'),
              // subtitle: Text('Tag-ID'),
            ),
          ),
          Expanded(
            child: ListTile(
              title: SelectableText(assignment.from.toLocal().toString()),
              // subtitle: Text('zugewiesen von'),
            ),
          ),
          Expanded(
            child: ListTile(
              title: SelectableText(
                assignment.to?.toNiceString() ?? '---',
              ),
              // subtitle: Text('bis'),
            ),
          ),
        ],
      ),
    );
  }
}

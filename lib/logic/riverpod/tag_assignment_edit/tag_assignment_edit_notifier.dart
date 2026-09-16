import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';

part 'tag_assignment_edit_notifier.freezed.dart';

@freezed
class TagAssignmentEditState with _$TagAssignmentEditState {
  final List<TagAssignment> originals;
  final List<TagAssignment> newAssignments;

  List<TagAssignment> get full => [...originals, ...newAssignments];

  TagAssignmentEditState({
    required this.originals,
    required this.newAssignments,
  });
}

class TagAssignmentEditNotifier extends Notifier<TagAssignmentEditState> {
  @override
  TagAssignmentEditState build() =>
      TagAssignmentEditState(originals: [], newAssignments: []);

  void load(String customerID) async {
    final assignments = await ref
        .read(tagAssignmentRepoProvider)
        .assignmentsByCustomer(customerID: customerID);
    state = TagAssignmentEditState(originals: assignments, newAssignments: []);
  }

  void addAssignment(TagAssignment assignment) {
    if (state.originals
            .where(
              (element) => element.tagID == assignment.tagID,
            )
            .isNotEmpty ||
        state.originals
            .where(
              (element) => element.tagID == assignment.tagID,
            )
            .isNotEmpty) {
      return;
    }
    final nextNewAssignments = state.newAssignments.toList();
    nextNewAssignments.add(assignment);
    state = state.copyWith(newAssignments: nextNewAssignments);
  }

  void saveNew(String customerID) {
    ref
        .read(tagAssignmentRepoProvider)
        .insertAll(
          state.newAssignments
              .map(
                (e) => e.copyWith(customerID: customerID),
              )
              .toList(),
        );
    load(customerID);
  }
}

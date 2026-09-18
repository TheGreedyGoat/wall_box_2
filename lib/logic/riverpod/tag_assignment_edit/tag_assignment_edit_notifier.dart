import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';

part 'tag_assignment_edit_notifier.freezed.dart';

@freezed
/// Stores changes made while editing a [Customer]'s tag assignments
///
/// Changes here will not alter the database until the notifier's [saveNew] is called
class TagAssignmentEditState with _$TagAssignmentEditState {
  @override
  final List<TagAssignment> originals;
  @override
  final List<TagAssignmentModification> modifiedAssignments;

  /// untouched originals
  List<TagAssignment> get unmodified => originals
      .where(
        (original) => modifiedAssignments
            .where(
              (mod) => mod.original?.tagID == original.tagID,
            )
            .isEmpty,
      )
      .toList();

  /// originals that got changed
  List<TagAssignment> get modified => modifiedAssignments
      .where(
        (mod) => mod.original != null && mod.change != null,
      )
      .map(
        (e) => e.change!,
      )
      .toList();

  /// completely new assignments
  List<TagAssignment> get added => modifiedAssignments
      .where(
        (mod) => mod.original == null && mod.change != null,
      )
      .map(
        (e) => e.change!,
      )
      .toList();

  /// deleted originals
  List<TagAssignment> get removed => modifiedAssignments
      .where(
        (mod) => mod.original != null && mod.change == null,
      )
      .map(
        (e) => e.original!,
      )
      .toList();

  ///
  /// - [modifiedAssignments]: Stores all new and changed tag assignments
  TagAssignmentEditState({
    required this.originals,
    required this.modifiedAssignments,
  });
}

@freezed
class TagAssignmentModification with _$TagAssignmentModification {
  /// null => new assignment
  final TagAssignment? original;

  final TagAssignment? change;

  String? get tagID => original?.tagID ?? change?.tagID;

  TagAssignmentModification({this.original, required this.change});
}

/// Notifier for [TagAssignmentEditState].
///
/// Changes here will not alter the database until [saveNew] is called
///
class TagAssignmentEditNotifier extends Notifier<TagAssignmentEditState> {
  @override
  TagAssignmentEditState build() => TagAssignmentEditState(
    originals: [],
    modifiedAssignments: [],
  );

  /// pulls all the tag assignments for the passed [customerID] wich are currently in the database.
  /// Those items will be put into the states originals field
  ///
  /// If [customerID] is null or no assignments were found, an empty state is set
  ///
  void load(String? customerID) async {
    final assignments = customerID != null
        ? await ref
              .read(tagAssignmentRepoProvider)
              .assignmentsByCustomer(customerID: customerID)
        : <TagAssignment>[];
    state = TagAssignmentEditState(
      originals: assignments,
      modifiedAssignments: [],
    );
  }

  /// checks if
  void addAssignment(
    TagAssignment assignment,
    void Function() alreadyAssignedCallback,
  ) {
    // this tag is already actively assigned to this customer
    // => assignment is redundant
    if (state.originals
        .where(
          (element) => element.tagID == assignment.tagID && element.to == null,
        )
        .isNotEmpty) {
      //notify user
      alreadyAssignedCallback();
      return;
    }
    final changes = state.modifiedAssignments.toList();
    // remove earlier changes
    changes.removeWhere(
      (change) =>
          change.original?.tagID == assignment.tagID ||
          change.change?.tagID == assignment.tagID,
    );
    changes.add(TagAssignmentModification(change: assignment));
    state = state.copyWith(modifiedAssignments: changes);

    changed();
  }

  void revertChange(String tagID) {
    final mods = state.modifiedAssignments.toList();
    mods.removeWhere(
      (mod) => mod.tagID == tagID,
    );
    state = state.copyWith(modifiedAssignments: mods);
  }

  void setAssignmentEnd(String tagID, DateTime end) {
    final modifiedAssignments = state.modifiedAssignments.toList();
    // check if there already is a change for this tagID
    int index = modifiedAssignments.indexWhere(
      (mod) => mod.change?.tagID == tagID,
    );

    if (index >= 0) {
      final mod = modifiedAssignments[index];
      final change = mod.change!;
      modifiedAssignments[index] = mod.copyWith(
        change: change.copyWith(to: end),
      );
    } else {
      final original = state.originals
          .where(
            (orig) => orig.tagID == tagID,
          )
          .firstOrNull;
      if (original == null) return;
      modifiedAssignments.add(
        TagAssignmentModification(
          original: original,
          change: original.copyWith(to: end),
        ),
      );
    }
    state = state.copyWith(modifiedAssignments: modifiedAssignments);
    changed();
  }

  setDeletion(String tagID) {
    final original = state.originals
        .where(
          (element) => element.tagID == tagID,
        )
        .firstOrNull;
    if (original == null) return;
    final mods = state.modifiedAssignments.toList();
    mods.removeWhere(
      (element) => element.tagID == tagID,
    );
    mods.add(TagAssignmentModification(original: original, change: null));
    state = state.copyWith(modifiedAssignments: mods);
  }

  void changed() => ref.read(customerEditChangeProvider.notifier).set(true);

  Future<void> saveNew(String customerID) async {
    final mods = state.modifiedAssignments;
    final repo = ref.read(tagAssignmentRepoProvider);
    for (final mod in mods) {
      if (mod.change != null) {
        await repo.insert(mod.change!);
      } else if (mod.original != null) {
        await repo.deleteWhereTagID(mod.original!.tagID);
      }
    }
    load(customerID);
  }
}

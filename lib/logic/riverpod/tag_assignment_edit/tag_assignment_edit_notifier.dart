import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/repositories/tag_assignment_repo.dart';
import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';

part 'tag_assignment_edit_notifier.freezed.dart';

@freezed
/// Stores changes made while editing a [Customer]'s tag assignments
///
/// Changes here will not alter the database until the notifier's [saveNew] is called
class TagAssignmentEditState with _$TagAssignmentEditState {
  @override
  final String? customerID;
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
  List<TagAssignmentModification> get modified => modifiedAssignments
      .where(
        (mod) => mod.original != null && mod.change != null,
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
    required this.customerID,
    required this.originals,
    required this.modifiedAssignments,
  });
}

@freezed
/// Tracks changes on Tagassignments
///
/// the field [original] is supposed to store an assigment as it is currently saved within the database,
/// [change] stores the new version.
///
/// ## Attention
///
/// only use for actual changes! Storing an original and setting changed to null rasults in deletion of the original!
///
/// ### Interpretations:
/// - original != null && change != null => an existing [TagAssignment] is to be changed
/// - original == null && change != null => new [TagAssignment] to be added
/// - original != null && change == null => existing [TagAssignment] to be deleted
///
/// other combinations should not occur
///
class TagAssignmentModification with _$TagAssignmentModification {
  @override
  /// set, if an already saved assignment is supposed to be changed or deleted
  ///
  /// unset to add a new assignment
  final TagAssignment? original;

  @override
  /// this is the assignment that is going to be added or updated
  ///
  /// If [original] is set and [change] is null, the corresponding original will be deleted from the database
  final TagAssignment? change;

  /// quick access to the tagID (since one of [original] and [change] should always be non-null, this also should)
  String? get tagID => original?.tagID ?? change?.tagID;

  /// Tracks changes on Tagassignments
  ///
  /// the field [original] is supposed to store an assigment as it is currently saved within the database,
  /// [change] stores the new version.
  ///
  /// ## Attention
  ///
  /// only use for actual changes! Storing an original and setting changed to null rasults in deletion of the original!
  ///
  /// ### Interpretations:
  /// - original != null && change != null => an existing [TagAssignment] is to be changed
  /// - original == null && change != null => new [TagAssignment] to be added
  /// - original != null && change == null => existing [TagAssignment] to be deleted
  ///
  /// other combinations should not occur
  ///
  TagAssignmentModification({this.original, required this.change});
}

/// Notifier for [TagAssignmentEditState].
///
/// Changes here will not alter the database until [saveChanges] is called
///
class TagAssignmentEditNotifier extends Notifier<TagAssignmentEditState> {
  @override
  TagAssignmentEditState build() => TagAssignmentEditState(
    customerID: '',
    originals: [],
    modifiedAssignments: [],
  );
  @override
  set state(TagAssignmentEditState value) {
    for (final mod in state.modifiedAssignments) {
      print(mod.change);
    }
    super.state = value;
  }

  TagAssignmentRepo get repo => ref.read(tagAssignmentRepoProvider);

  /// Sets the id only if it's not set yet
  void setCustomerID(String? customerID) => state = state.customerID == null
      ? state.copyWith(customerID: customerID)
      : state;

  /// pulls all the tag assignments for the passed [customerID] wich are currently in the database.
  /// Those items will be put into the states originals field
  ///
  /// If [customerID] is null or no assignments were found, an empty state is set
  ///
  Future<void> load(String? customerID) async {
    final assignments = customerID != null
        ? await ref
              .read(tagAssignmentRepoProvider)
              .assignmentsByCustomer(customerID: customerID)
        : <TagAssignment>[];
    state = TagAssignmentEditState(
      customerID: customerID ?? '',
      originals: assignments,
      modifiedAssignments: [],
    );
    ref.read(customerEditProvider.notifier).tagsChanged = false;
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
    state = state.copyWith(
      modifiedAssignments: changes,
    );

    changed();
  }

  /// Undos all changes made to the TagAssignemts
  void revertChange(String tagID) {
    final mods = state.modifiedAssignments.toList();
    mods.removeWhere(
      (mod) => mod.tagID == tagID,
    );
    state = state.copyWith(modifiedAssignments: mods);
  }

  /// undos all changes made to the tagassignment list
  void revertAll() => load(state.customerID);

  /// sets the end date of a yet unfinished assignment
  ///
  /// the start date is required to ensure we edit the corrent assignment
  void setAssignmentEnd(String tagID, DateTime start, DateTime end) {
    final modifiedAssignments = state.modifiedAssignments.toList();
    // check if there already is a change for this tagID
    int index = modifiedAssignments.indexWhere(
      (mod) => mod.change?.tagID == tagID && mod.change?.from == start,
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

  /// sets up a specific original assigment for deletion
  void setDeletion(String tagID, DateTime from) {
    final original = state.originals
        .where(
          (element) => element.tagID == tagID,
        )
        .firstOrNull;
    if (original == null) return;
    final mods = state.modifiedAssignments.toList();
    mods.removeWhere(
      (element) => element.tagID == tagID && element.original!.from == from,
    );
    mods.add(TagAssignmentModification(original: original, change: null));
    state = state.copyWith(modifiedAssignments: mods);
    changed();
  }

  /// tell the Change Notifier that achange was made
  void changed() => ref.read(customerEditProvider.notifier).tagsChanged = true;

  /// applies all changes to the database
  Future<int> saveChanges(String customerID) async {
    int changes = 0;
    final modified = state.modified;
    final added = state.added;
    final removed = state.removed;

    for (final mod in modified) {
      changes += await repo.update(mod.original, mod.change);
    }

    for (final add in added) {
      changes != await repo.insert(add);
    }

    for (final del in removed) {
      changes += await repo.deleteByPrimaries(del);
    }
    unawaited(load(customerID));
    return changes;
  }
}

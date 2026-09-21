import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/units/euro.dart';
import 'package:wall_box_2/logic/models/assignments/price_assignment.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';

part 'price_assignment_edit_notifier.freezed.dart';

@freezed
/// Stores changes while editing a customer's price assignments.
class PriceAssignmentEditState with _$PriceAssignmentEditState {
  @override
  /// the kWh price entered by the user
  final Euro? price;
  @override
  /// The assignment start date selected by the user
  final DateTime? selectedDate;
  @override
  /// stores the earliest date a new assignment to the current customer can be dated to
  final DateTime earliestAvailable;

  /// Stores changes while editing a customer's price assignments.
  PriceAssignmentEditState({
    this.price,
    required this.earliestAvailable,
    this.selectedDate,
  });
}

/// Manages changes while editing a customer's price assignments.
class PriceAssignmentEditNotifier extends Notifier<PriceAssignmentEditState> {
  PriceAssignmentEditState get _defaultState => PriceAssignmentEditState(
    earliestAvailable: DateTime.now().subtract(Duration(days: 365)),
  );
  @override
  PriceAssignmentEditState build() => _defaultState;

  /// loads the customer's current price assignment (if existant) aswell as the earliest available date for a reassignment into the state.
  ///
  /// if no id is passed, a default state will be passed
  void load(String? customerID) {
    if (customerID == null) {
      state = _defaultState;
      return;
    }
    ref.read(priceAssignmentRepoProvider).getActiveAssignment(customerID).then(
      (value) async {
        state = PriceAssignmentEditState(
          price: value?.price,
          earliestAvailable: await ref
              .read(priceAssignmentRepoProvider)
              .getEarliestAvailablePriceassignmentDate(customerID),
        );
      },
    );
    ref.read(customerEditProvider.notifier).priceChanged = false;
  }

  /// saves the state's date into a new assignment, assigning it to the [customerID]
  Future<void> save(String customerID) async {
    // print(state.price);
    // print(state.selectedDate);
    if (state.price == null || state.selectedDate == null) return;
    final repo = ref.read(priceAssignmentRepoProvider);
    final active = await repo.getActiveAssignment(customerID);

    if (active != null) {
      // nothing changed
      if (active.price == state.price) return;
      await repo.insert(active.copyWith(to: state.selectedDate));
    }
    await repo.insert(
      PriceAssignment(
        customerID: customerID,
        price: state.price!,
        from: state.selectedDate!,
      ),
    );
  }

  /// set the state's kWh price
  void setPrice(int centicents) {
    state = state.copyWith(price: Euro(centicents));
    changed();
  }

  /// set the date when the assignment will start
  void setStartDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
    changed();
  }

  /// updates the Editor notifier something changed with the price assignments
  void changed() => ref.read(customerEditProvider.notifier).priceChanged = true;
}

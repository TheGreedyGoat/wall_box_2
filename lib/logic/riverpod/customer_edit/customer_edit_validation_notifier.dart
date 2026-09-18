import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/language/language.dart';

/// tracks errors that hint to invalid or missing data inputs
///
/// eg a missing name or city

class CustomerEditErrorState {
  /// This is where the data errors get stored.
  ///
  final List<DataError> errors;

  /// tracks errors that hint to invalid or missing data inputs
  ///
  /// eg a missing name or city

  CustomerEditErrorState({required this.errors});

  /// use as errorText argument a Text(Form)Field's decorator
  ///
  /// Just pass the type of error you want the widget to 'react' to
  ///
  String? getMessage(DataError error) =>
      errors.contains(error) ? currentLanguage.getDataErrorMsg(error) : null;
}

/// Notifier for tracking errors where Customer Data are edited.
///
/// eg a missing name or city
class CustomerEditValidationNotifier extends Notifier<CustomerEditErrorState> {
  @override
  CustomerEditErrorState build() => CustomerEditErrorState(errors: []);

  /// requests a validation from the current customer edit state.
  ///
  /// Any errors the notifier finds will be stored in the state
  ///
  CustomerEditErrorState validate() {
    state = CustomerEditErrorState(
      errors: ref.read(customerEditProvider).validate(),
    );
    return state;
  }

  /// clears all errors
  void clear() {
    state = CustomerEditErrorState(errors: []);
  }
}

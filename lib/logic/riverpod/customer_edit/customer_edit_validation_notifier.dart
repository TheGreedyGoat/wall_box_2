import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/language/language.dart';

class CustomerEditErrorState {
  final List<DataError> errors;

  CustomerEditErrorState({required this.errors});

  String? getMessage(DataError error) =>
      errors.contains(error) ? currentLanguage.getDataErrorMsg(error) : null;
}

class CustomerEditValidationNotifier extends Notifier<CustomerEditErrorState> {
  @override
  CustomerEditErrorState build() => CustomerEditErrorState(errors: []);

  CustomerEditErrorState validate() {
    state = CustomerEditErrorState(
      errors: ref.read(customerEditProvider).validate(),
    );
    return state;
  }

  void clear() {
    state = CustomerEditErrorState(errors: []);
  }
}

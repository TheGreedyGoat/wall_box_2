import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';

/// holds the current selected [CustomerDataPackage].
///
/// Should only be set to packages as they are in the database or null if none should be selected
class SelectedCustomerNotifier extends Notifier<CustomerDataPackage?> {
  @override
  CustomerDataPackage? build() => null;

  /// Should only be set to packages as they are in the database or null if none should be selected
  set data(CustomerDataPackage? data) {
    state = data;
  }
}

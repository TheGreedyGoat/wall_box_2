import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';

class SelectedCustomerNotifier extends Notifier<CustomerDataPackage?> {
  @override
  CustomerDataPackage? build() => null;

  set data(CustomerDataPackage? data) => state = data;
}

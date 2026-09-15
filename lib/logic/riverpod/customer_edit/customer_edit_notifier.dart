import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/data/interface_models/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/customer.dart';

class CustomerEditNotifier extends Notifier<CustomerDataPackage> {
  @override
  CustomerDataPackage build() => CustomerDataPackage(
    customer: Customer(id: ''),
    address: Address(customerID: ''),
    contact: null,
    company: null,
    personal: null,
  );

  void setId(String id) {
    state = state.copyWith(
      customer: state.customer.copyWith(id: id),
      address: state.address.copyWith(customerID: id),
      contact: state.contact?.copyWith(customerID: id),
      company: state.company?.copyWith(customerID: id),
      personal: state.personal?.copyWith(customerID: id),
    );
  }
}

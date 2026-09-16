import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_state.freezed.dart';

@freezed
class DatabaseChangeState with _$DatabaseChangeState {
  final int address;
  final int company;
  final int contact;
  final int customer;
  final int personal;
  final int priceAssignment;
  final int tagAssignment;
  final int transactRepo;
  final int customerPackage;

  DatabaseChangeState({
    required this.address,
    required this.company,
    required this.contact,
    required this.customer,
    required this.personal,
    required this.priceAssignment,
    required this.tagAssignment,
    required this.transactRepo,
  }) : customerPackage = customer + address + contact + company + personal;

  DatabaseChangeState.init()
    : this(
        address: 0,
        company: 0,
        contact: 0,
        customer: 0,
        personal: 0,
        priceAssignment: 0,
        tagAssignment: 0,
        transactRepo: 0,
      );
}

class DatabaseChangeNotifier extends Notifier<DatabaseChangeState> {
  @override
  DatabaseChangeState build() => DatabaseChangeState.init();

  void addressChanged() => state = state.copyWith(address: state.address + 1);

  void companyChanged() => state = state.copyWith(company: state.company + 1);
  void contactChanged() => state = state.copyWith(contact: state.contact + 1);
  void customerChanged() =>
      state = state.copyWith(customer: state.customer + 1);
  void personalChanged() =>
      state = state.copyWith(personal: state.personal + 1);
  void priceAssignmentChanged() =>
      state = state.copyWith(priceAssignment: state.priceAssignment + 1);
  void tagAssignmentChanged() =>
      state = state.copyWith(tagAssignment: state.tagAssignment + 1);
  void transactionChanged() =>
      state = state.copyWith(transactRepo: state.transactRepo + 1);
}

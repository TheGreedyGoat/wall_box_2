// ignore_for_file: public_member_api_docs

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'change_state.freezed.dart';

@freezed
/// Notifies the ui when changes are made in the database.
///
/// The integers are just dummy values to be incremented whenever a change is made.
/// For each table there is one corresponding integer
///
class DatabaseChangeState with _$DatabaseChangeState {
  @override
  final int address;
  @override
  final int company;
  @override
  final int contact;
  @override
  final int customer;
  @override
  final int personal;
  @override
  final int priceAssignment;
  @override
  final int tagAssignment;
  @override
  final int transactRepo;
  @override
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

/// Notifies the ui when changes are made in the database.
///
/// The integers are just dummy values to be incremented whenever a change is made.
/// For each table there is one corresponding integer
///
/// to trigger an update call the corresponding ___Changed() method
///
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal/personal_data.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';

class CustomerEditNotifier extends Notifier<CustomerDataPackage> {
  @override
  CustomerDataPackage build() => CustomerDataPackage.empty;

  void set(CustomerDataPackage? data) =>
      state = data ?? CustomerDataPackage.empty;

  void setId(String id) {
    state = state.copyWith(
      customer: state.customer.copyWith(id: id),
      address: state.address.copyWith(customerID: id),
      contact: state.contact?.copyWith(customerID: id),
      company: state.company?.copyWith(customerID: id),
      personal: state.personal?.copyWith(customerID: id),
    );
  }

  void update<T>({
    required T Function(CustomerDataPackage state) getProperty,
    required CustomerDataPackage Function(T property) updater,
  }) {
    state = updater(getProperty(state));
  }

  void updateCompany({
    required CompanyData Function(CompanyData companyData) changes,
  }) {
    state = state.copyWith(
      company: changes(
        state.company ?? CompanyData(customerID: state.id, companyName: ''),
      ),
    );
  }

  void updatePersonals({
    required PersonalData Function(PersonalData personalData) changes,
  }) {
    state = state.copyWith(
      personal: changes(state.personal ?? PersonalData(customerID: state.id)),
    );
  }

  void updateAddress({
    required Address Function(Address address) changes,
  }) {
    state = state.copyWith(
      address: changes(state.address),
    );
  }

  void updateContact({
    required ContactData Function(ContactData contact) changes,
  }) {
    state = state.copyWith(
      contact: changes(state.contact ?? ContactData(customerID: state.id)),
    );
  }

  void reset() {
    state = CustomerDataPackage.empty;
    ref.read(customerErrorProvider.notifier).clear();
  }

  Future<void> save({
    required void Function() onSuccess,
    required void Function(Object?) onError,
  }) async {
    try {
      assert(state.company != null || state.personal != null);
      assert(state.customer.id == state.address.customerID);
      assert(
        state.contact == null || state.customer.id == state.contact!.customerID,
      );
      assert(
        state.company == null || state.customer.id == state.company!.customerID,
      );
      assert(
        state.personal == null ||
            state.customer.id == state.personal!.customerID,
      );

      assert(state.customer.isValid);
      assert(state.address.isValid);
      assert(state.contact?.isValid ?? true);
      assert(state.company?.isValid ?? true);
      assert(state.personal?.isValid ?? true);

      final db = await AppDatabase.instance.database;

      await ref.read(customerRepoProvider).insert(state.customer);
      await ref.read(addressRepoProvider).insert(state.address);
      if (state.contact != null) {
        await ref.read(contactRepoProvider).insert(state.contact!);
      }
      if (state.company != null) {
        await ref.read(companyRepoProvider).insert(state.company!);
      }
      if (state.personal != null) {
        await ref.read(personalRepoProvider).insert(state.personal!);
      }

      ref.read(tagAssignmenteditProvider.notifier).saveNew(state.id);
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal/personal_data.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';

/// This notifier is used to be notified as soon as a change is made within the Customer edit page
///
/// If state is true, the save and discard button's will be visible, else they stay hidden.
/// This is supposed to prevent unnessecary saving when nothing changed, aswell as giving the user a visual indicator
/// and remind them of saving (or discarding) their changes
class CustomerEditChangeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  /// set the state's value
  void set(bool value) => state = value;
}

/// Core Notifier for creating and editing Customer data profiles
///
/// stores all changes made. Changes are only updated when save() is called
class CustomerEditNotifier extends Notifier<CustomerDataPackage> {
  @override
  CustomerDataPackage build() => CustomerDataPackage.empty;

  CustomerEditChangeNotifier get _changeNotifier =>
      ref.read(customerEditChangeProvider.notifier);

  /// set the state's value. If [data] == null, an empty data package will be set
  void set(CustomerDataPackage? data) =>
      state = data ?? CustomerDataPackage.empty;

  void load(String? customerID) async {
    if (customerID == null) {
      set(null);
      return;
    }
    ref.read(customerPackageProvider).whenData(
      (packs) {
        set(
          packs
              .where(
                (pack) => pack.id == customerID,
              )
              .firstOrNull,
        );
      },
    );
  }

  /// update the customerID consistently
  void setId(String id) {
    state = state.copyWith(
      customer: state.customer.copyWith(id: id),
      address: state.address.copyWith(customerID: id),
      contact: state.contact?.copyWith(customerID: id),
      company: state.company?.copyWith(customerID: id),
      personal: state.personal?.copyWith(customerID: id),
    );
  }

  /// pass custom logic on how to update the state.
  /// the current state will be passed to the [updater].
  ///
  /// The return value will be the new state
  ///
  void update({
    required CustomerDataPackage Function(CustomerDataPackage state) updater,
  }) {
    state = updater(state);
    _changeNotifier.set(true);
  }

  /// update company data
  void updateCompany({
    required CompanyData Function(CompanyData companyData) changes,
  }) {
    update(
      updater: (state) => state.copyWith(
        company: changes(
          state.company ?? CompanyData(customerID: state.id, companyName: ''),
        ),
      ),
    );
  }

  /// update personal data
  void updatePersonals({
    required PersonalData Function(PersonalData personalData) changes,
  }) {
    update(
      updater: (state) => state.copyWith(
        personal: changes(state.personal ?? PersonalData(customerID: state.id)),
      ),
    );
  }

  /// update address
  void updateAddress({
    required Address Function(Address address) changes,
  }) {
    update(
      updater: (state) => state.copyWith(
        address: changes(state.address),
      ),
    );
  }

  /// update contact data
  void updateContact({
    required ContactData Function(ContactData contact) changes,
  }) {
    update(
      updater: (state) => state.copyWith(
        contact: changes(state.contact ?? ContactData(customerID: state.id)),
      ),
    );
  }

  /// fully resets the state to be empty
  void reset() {
    state = CustomerDataPackage.empty;
    ref.read(customerErrorProvider.notifier).clear();
    ref.read(customerEditChangeProvider.notifier).set(false);
  }

  /// attempts to save the current state into the database.
  ///
  /// To ensure the saving process is successful, use state.validate() before saving and only save if the returned list is empty
  ///
  /// Use the two callbacks to add more logic to the outcomes
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

      await ref.read(tagAssignmenteditProvider.notifier).saveNew(state.id);
      await ref.read(priceAssignmentEditProvider.notifier).save(state.id);

      ref.read(customerEditChangeProvider.notifier).set(false);
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }
}

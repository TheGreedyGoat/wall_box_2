import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
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

/// Stores, what is currently entered on a customer's page
///
class CustomerEditState {
  /// the customer's data
  final CustomerDataPackage data;

  /// The originally loaded customer's id
  ///
  /// only != data.id if a new customer is being created and the input field is edited
  final CustomerDataPackage? original;

  /// Stores, what is currently entered on a customer's page
  ///
  CustomerEditState({
    CustomerDataPackage? data,
    this.original,
  }) : this.data = data ?? CustomerDataPackage.empty;

  /// returns a new instance with the old [original] and a new datapack
  CustomerEditState updateData(CustomerDataPackage newData) =>
      CustomerEditState(data: newData, original: original);

  /// quick access to the customer id
  String get id => data.id;

  /// shortcut for
  /// ```dart
  ///   originalCustomerID == null;
  /// ```
  bool get isCreation => original == null;
}

// class IDEditingEnabledNotifier extends Notifier<bool>{}

/// Core Notifier for creating and editing Customer data profiles
///
/// stores all changes made. Changes are only updated when save() is called
class CustomerEditNotifier extends Notifier<CustomerEditState> {
  bool _mainChanged = false, _tagsChanged = false, _priceChanged = false;
  set mainChanged(bool value) {
    _mainChanged = value;
    checkChanges();
  }

  set tagsChanged(bool value) {
    _tagsChanged = value;
    checkChanges();
  }

  set priceChanged(bool value) {
    _priceChanged = value;
    checkChanges();
  }

  /// shortcut to the state's data package
  CustomerDataPackage get data => state.data;

  @override
  CustomerEditState build() => CustomerEditState(
    data: CustomerDataPackage.empty,
    original: null,
  );

  CustomerEditChangeNotifier get _changeNotifier =>
      ref.read(customerEditChangeProvider.notifier);

  void _setCustomer(CustomerDataPackage? data) =>
      state = CustomerEditState(data: data, original: data);

  /// updates the changenotifier to be true there is currently any change active
  void checkChanges() => ref
      .read(customerEditChangeProvider.notifier)
      .set(_mainChanged || _tagsChanged || _priceChanged);

  /// loads the current database state of the corresponding customer into the notifier
  ///
  /// Also triggers the tag- and priceAssignemnt notifier to fetch from the database
  Future<void> load(String? customerID) async {
    if (customerID == null) {
      _setCustomer(null);
    } else {
      final packs = await ref.read(customerPackageProvider.future);
      _setCustomer(
        packs
            .where(
              (pack) => pack.id == customerID,
            )
            .firstOrNull,
      );
    }
    await ref.read(tagAssignmenteditProvider.notifier).load(customerID);
    await ref.read(priceAssignmentEditProvider.notifier).load(customerID);
    ref.read(customerEditChangeProvider.notifier).set(false);
  }

  /// resets the state to show the original data
  Future<void> reload() async {
    await load(state.original?.id);
  }

  /// update the customerID consistently
  void setId(String id) {
    final data = state.data;
    state = state.updateData(
      data.copyWith(
        customer: data.customer.copyWith(id: id),
        address: data.address.copyWith(customerID: id),
        contact: data.contact?.copyWith(customerID: id),
        company: data.company?.copyWith(customerID: id),
        personal: data.personal?.copyWith(customerID: id),
      ),
    );

    ref.read(tagAssignmenteditProvider.notifier).setCustomerID(id);
    mainChanged = true;
  }

  /// pass custom logic on how to update the state.
  /// the current state will be passed to the [updater].
  ///
  /// The return value will be the new state
  ///
  void update({
    required CustomerDataPackage Function(CustomerDataPackage state) updater,
  }) {
    state = state.updateData(updater(state.data));
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

  /// attempts to save the current state into the database.
  ///
  /// To ensure the saving process is successful, use state.validate() before saving and only save if the returned list is empty
  ///
  /// Use the two callbacks to add more logic to the outcomes
  Future<void> validateAndTrySave({
    required void Function() onSuccess,
    required void Function(Object?) onError,
  }) async {
    try {
      if (!(await ref.read(customerErrorProvider.notifier).validate())) return;
      final customerRepo = ref.read(customerRepoProvider);
      final addressRepo = ref.read(addressRepoProvider);

      final companyRepo = ref.read(companyRepoProvider);
      final personalRepo = ref.read(personalRepoProvider);
      final contactRepo = ref.read(contactRepoProvider);

      // ignore: unused_local_variable
      int changes = 0;

      if (state.original == null) {
        // => new customer => insert
        changes += await customerRepo.insert(state.data.customer);
        changes += await addressRepo.insert(state.data.address);

        if (state.data.company != null) {
          changes += await companyRepo.insert(state.data.company!);
        }
        if (state.data.personal != null) {
          changes += await personalRepo.insert(state.data.personal!);
        }

        if (state.data.contact != null) {
          changes += await contactRepo.insert(state.data.contact!);
        }
      } else {
        //=> edit => update
        changes += await customerRepo.update(
          state.original!.customer,
          state.data.customer,
        );
        changes += await addressRepo.update(
          state.original!.address,
          state.data.address,
        );
        changes += await companyRepo.update(
          state.original!.company!,
          state.data.company!,
        );
        changes += await personalRepo.update(
          state.original!.personal,
          state.data.personal,
        );
        changes += await contactRepo.update(
          state.original!.contact,
          state.data.contact,
        );
      }

      changes += await ref
          .read(tagAssignmenteditProvider.notifier)
          .saveChanges(data.id);
      changes += await ref
          .read(priceAssignmentEditProvider.notifier)
          .save(data.id);

      _mainChanged = false;
      _tagsChanged = false;
      _priceChanged = false;
      onSuccess();
    } catch (e) {
      onError(e);
    }
  }
}

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

// class IDEditingEnabledNotifier extends Notifier<bool>{}

/// Core Notifier for creating and editing Customer data profiles
///
/// stores all changes made. Changes are only updated when save() is called
class CustomerEditNotifier extends Notifier<CustomerDataPackage> {
  bool _mainChanged = false, _tagsChanged = false, _priceChanged = false;
  CustomerDataPackage? get original => ref.read(selectedCustomerDataProvider);

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

  @override
  CustomerDataPackage build() {
    final selected = ref.read(selectedCustomerDataProvider);
    ref.listen(
      selectedCustomerDataProvider,
      (previous, next) => load(next),
    );
    return selected ?? CustomerDataPackage.empty;
  }

  CustomerEditChangeNotifier get _changeNotifier =>
      ref.read(customerEditChangeProvider.notifier);

  void _setCustomer(CustomerDataPackage data) {
    state = data;
  }

  /// updates the changenotifier to be true there is currently any change active
  void checkChanges() => ref
      .read(customerEditChangeProvider.notifier)
      .set(_mainChanged || _tagsChanged || _priceChanged);

  /// loads the current database state of the corresponding customer into the notifier
  ///
  /// Also triggers the tag- and priceAssignemnt notifier to fetch from the database
  Future<void> load([CustomerDataPackage? customer]) async {
    final data = customer ?? CustomerDataPackage.empty;

    _setCustomer(data);

    await ref.read(tagAssignmenteditProvider.notifier).load(data.id);
    await ref.read(priceAssignmentEditProvider.notifier).load(data.id);
    ref.read(customerEditChangeProvider.notifier).set(false);
  }

  /// update the customerID consistently
  void setId(String id) {
    final data = state;
    state = data.copyWith(
      customer: data.customer.copyWith(id: id),
      address: data.address.copyWith(customerID: id),
      contact: data.contact?.copyWith(customerID: id),
      company: data.company?.copyWith(customerID: id),
      personal: data.personal?.copyWith(customerID: id),
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
      final errors = await ref.read(customerErrorProvider.notifier).validate();
      if (errors.isNotEmpty) {
        print(errors);
        return;
      }
      final customerRepo = ref.read(customerRepoProvider);
      final addressRepo = ref.read(addressRepoProvider);

      final companyRepo = ref.read(companyRepoProvider);
      final personalRepo = ref.read(personalRepoProvider);
      final contactRepo = ref.read(contactRepoProvider);

      // ignore: unused_local_variable
      int changes = 0;

      if (original == null) {
        print('new insert');
        // => new customer => insert
        changes += await customerRepo.insert(state.customer);
        changes += await addressRepo.insert(state.address);

        if (state.company != null) {
          changes += await companyRepo.insert(state.company!);
        }
        if (state.personal != null) {
          changes += await personalRepo.insert(state.personal!);
        }

        if (state.contact != null) {
          changes += await contactRepo.insert(state.contact!);
        }
      } else {
        print(state.contact);
        //=> edit => update
        changes += await customerRepo.update(
          original!.customer,
          state.customer,
        );
        changes += await addressRepo.update(
          original!.address,
          state.address,
        );
        changes += await companyRepo.update(
          original!.company!,
          state.company!,
        );
        changes += await personalRepo.update(
          original!.personal,
          state.personal,
        );
        changes += await contactRepo.update(
          original!.contact,
          state.contact,
        );
      }

      changes += await ref
          .read(tagAssignmenteditProvider.notifier)
          .saveChanges(state.id);
      changes += await ref
          .read(priceAssignmentEditProvider.notifier)
          .save(state.id);

      _mainChanged = false;
      _tagsChanged = false;
      _priceChanged = false;
      onSuccess();
    } catch (e) {
      onError(e);
      rethrow;
    }
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/data/repositories/address_repo.dart';
import 'package:wall_box_2/data/repositories/company_repo.dart';
import 'package:wall_box_2/data/repositories/contact_repo.dart';
import 'package:wall_box_2/data/repositories/customer_repo.dart';
import 'package:wall_box_2/data/repositories/personal_repo.dart';
import 'package:wall_box_2/data/repositories/price_assignment_repo.dart';
import 'package:wall_box_2/data/repositories/tag_assignment_repo.dart';
import 'package:wall_box_2/data/repositories/transaction_repo.dart';
import 'package:wall_box_2/logic/models/master_data/custom_data/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/database_changes/change_state.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_validation_notifier.dart';
import 'package:wall_box_2/logic/riverpod/customer_price/price_assignment_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/tag_assignment_edit/tag_assignment_edit_notifier.dart';

// 8888888888     888 d8b 888
// 888            888 Y8P 888
// 888            888     888
// 8888888    .d88888 888 888888
// 888       d88" 888 888 888
// 888       888  888 888 888
// 888       Y88b 888 888 Y88b.
// 8888888888 "Y88888 888  "Y888

//=================These are the providers mainly used to manage the customer edit page========================//

/// Core provider for editing and creating customer data
///
/// The state is a CustomerDataPAckage instance containing general customer informations aswell as company- personal- address- and contact data
///
final customerEditProvider = NotifierProvider(
  () => CustomerEditNotifier(),
);

/// returns a boolean wich is true as soon as a change is made within the Customer edit page
final customerEditChangeProvider = NotifierProvider(
  () => CustomerEditChangeNotifier(),
);

/// manages changes for tag assignments within the Customer edit page
final tagAssignmenteditProvider = NotifierProvider(
  () => TagAssignmentEditNotifier(),
);

/// manages changes for price assignments within the Customer edit page
final priceAssignmentEditProvider = NotifierProvider(
  () => PriceAssignmentEditNotifier(),
);

/// Contains a list of [DataError]s
///
/// wich show the result of validating the [customerEditProvider]'s current data
///
final customerErrorProvider = NotifierProvider(
  () => CustomerEditValidationNotifier(),
);

//      888          888             888
//      888          888             888
//      888          888             888
//  .d88888  8888b.  888888  8888b.  88888b.   8888b.  .d8888b   .d88b.
// d88" 888     "88b 888        "88b 888 "88b     "88b 88K      d8P  Y8b
// 888  888 .d888888 888    .d888888 888  888 .d888888 "Y8888b. 88888888
// Y88b 888 888  888 Y88b.  888  888 888 d88P 888  888      X88 Y8b.
//  "Y88888 "Y888888  "Y888 "Y888888 88888P"  "Y888888  88888P'  "Y8888

/// Watch this to update whenever a database table changes it's content
final changeProvider = NotifierProvider(
  () => DatabaseChangeNotifier(),
);

/// pulls a list of all [CustomerDataPackage]s from the database
final customerPackageProvider = FutureProvider<List<CustomerDataPackage>>(
  (ref) async {
    final customers = await ref.watch(customerRepoProvider).allRows;
    List<CustomerDataPackage> result = List.empty(growable: true);

    for (final customer in customers) {
      final address = await ref.watch(addressRepoProvider).getByID(customer.id);
      if (address == null) continue;
      result.add(
        CustomerDataPackage(
          customer: customer,
          address: address,
          contact: await ref.watch(contactRepoProvider).getById(customer.id),
          company: await ref.watch(companyRepoProvider).getById(customer.id),
          personal: await ref.watch(personalRepoProvider).getById(customer.id),
        ),
      );
    }

    return result;
  },
);

/// Returns the repo for customers
final customerRepoProvider = Provider((ref) {
  ref.watch(
    changeProvider.select(
      (state) => state.customer,
    ),
  );
  return CustomerRepo(
    onchanged: () {
      ref.read(changeProvider.notifier).customerChanged();
    },
  );
});

/// Returns the repo for customer addresses
final addressRepoProvider = Provider((ref) {
  ref.watch(
    changeProvider.select(
      (state) => state.address,
    ),
  );
  return AddressRepo(
    onchanged: () => ref.read(changeProvider.notifier).addressChanged(),
  );
});

/// Returns the repo for customer contact data
final contactRepoProvider = Provider((ref) {
  ref.watch(
    changeProvider.select(
      (state) => state.contact,
    ),
  );
  return ContactRepo(
    onchanged: () => ref.read(changeProvider.notifier).contactChanged(),
  );
});

/// Returns the repo for customer company data
final companyRepoProvider = Provider((ref) {
  ref.watch(
    changeProvider.select(
      (state) => state.company,
    ),
  );
  return CompanyRepo(
    onchanged: () => ref.read(changeProvider.notifier).companyChanged(),
  );
});

/// Returns the repo for customer personal data
final personalRepoProvider = Provider((ref) {
  ref.watch(
    changeProvider.select(
      (state) => state.personal,
    ),
  );
  return PersonalRepo(
    onchanged: () => ref.read(changeProvider.notifier).personalChanged(),
  );
});

/// Returns the repo for tag assignments
final tagAssignmentRepoProvider = Provider(
  (ref) {
    ref.watch(
      changeProvider.select(
        (value) => value.tagAssignment,
      ),
    );
    return TagAssignmentRepo(
      onchanged: () => ref.read(changeProvider.notifier).tagAssignmentChanged(),
    );
  },
);

/// Returns the repo for price assignments
final priceAssignmentRepoProvider = Provider(
  (ref) {
    ref.watch(
      changeProvider.select(
        (value) => value.priceAssignment,
      ),
    );
    return PriceAssignmentRepo(
      onchanged: () =>
          ref.read(changeProvider.notifier).priceAssignmentChanged(),
    );
  },
);

final transactionRepoProvider = Provider(
  (ref) {
    ref.watch(
      changeProvider.select(
        (value) => value.transaction,
      ),
    );
    return TransactionRepo(
      onchanged: () => ref.read(changeProvider.notifier).transactionChanged(),
    );
  },
);

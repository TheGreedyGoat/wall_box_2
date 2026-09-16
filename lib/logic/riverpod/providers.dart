import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/data/repositories/address_repo.dart';
import 'package:wall_box_2/data/repositories/company_repo.dart';
import 'package:wall_box_2/data/repositories/contact_repo.dart';
import 'package:wall_box_2/data/repositories/customer_repo.dart';
import 'package:wall_box_2/data/repositories/personal_repo.dart';
import 'package:wall_box_2/data/repositories/tag_assignment_repo.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/changes/change_state.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_validation_notifier.dart';
import 'package:wall_box_2/logic/riverpod/tag_assignment_edit/tag_assignment_edit_notifier.dart';

final customerEditProvider = NotifierProvider(
  () => CustomerEditNotifier(),
);

final tagAssignmenteditProvider = NotifierProvider(
  () => TagAssignmentEditNotifier(),
);

final customerErrorProvider = NotifierProvider(
  () => CustomerEditValidationNotifier(),
);

// changeProviders
final changeProvider = NotifierProvider(
  () => DatabaseChangeNotifier(),
);

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

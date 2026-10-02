import 'package:wall_box_2/data/repositories/customer_repo.dart';
import 'package:wall_box_2/data/repositories/transaction_repo.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/helpers/percent.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal/personal_data.dart';
import 'package:wall_box_2/logic/models/transaction.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_master_data.dart';

class BillingData {
  final CompanyData? company;
  final PersonalData? personals;
  final Address address;
  final List<Transaction> transactions;
  final Percent discount;

  BillingData({
    this.company,
    this.personals,
    required this.address,
    required this.transactions,
    required this.discount,
  });

  BillingData.fromCustomer({
    required CustomerDataPackage customer,
    required this.transactions,
    this.discount = const Percent(0),
  }) : company = customer.company,
       personals = customer.personal,
       address = customer.address;
}

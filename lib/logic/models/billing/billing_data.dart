import 'package:wall_box_2/data/repositories/customer_repo.dart';
import 'package:wall_box_2/data/repositories/transaction_repo.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/helpers/percent.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';
import 'package:wall_box_2/logic/models/transaction.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/customer_master_data.dart';

class BillingData {
  final CustomerDataPackage customer;
  final TimeInterval interval;
  final List<Transaction> transactions;
  final Percent discount;

  const BillingData({
    required this.customer,
    required this.interval,
    required this.transactions,
    this.discount = const Percent(0),
  });

  String get name => customer.displayName;
  Address? get address => customer.address;
}

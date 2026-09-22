import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

class TransactionDataPack {
  final Transaction transaction;
  final CustomerDataPackage? customer;

  String get customerName => customer?.displayName ?? '[unbekannt]';

  TransactionDataPack({required this.transaction, required this.customer});
}

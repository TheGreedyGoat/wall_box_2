import 'package:wall_box_2/logic/models/assignments/tag_assignment.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

/// Combines data of a transaction with it's corresponding tag assignment and customer's data
class TransactionDataPack {
  /// the transaction
  final Transaction transaction;

  /// The tag assignment
  ///
  /// [tagAssignment] and [customerData] should either be both null or both non-null
  final TagAssignment? tagAssignment;

  /// the customer
  ///
  /// [tagAssignment] and [customerData] should either be both null or both non-null
  final CustomerDataPackage? customerData;

  /// returns the customer's name
  String get customerName => customerData?.displayName ?? '[nicht zugewiesen]';

  /// Combines data of a transaction with it's corresponding customer
  TransactionDataPack({
    required this.transaction,
    this.tagAssignment,
    this.customerData,
  });
}

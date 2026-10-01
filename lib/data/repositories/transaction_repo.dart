import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/tables/transaction_table.dart';
import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/data/repositories/tag_assignment_repo.dart';
import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

/// Saves all successfully scanned Transactions
class TransactionRepo extends Repository<Transaction> {
  /// Saves all successfully scanned Transactions
  TransactionRepo({required super.onchanged})
    : super(
        primaryKeyColumns: [TransactionColumns.id],
      );

  @override
  TransactionJsonConverter get converter => TransactionJsonConverter();

  @override
  String get tableName => TableNames.transaction;

  /// get a list of all distinct tagIDs
  Future<List<String>> get tagIds async {
    final qu = await queryAsJson(
      distinct: true,
      columns: [TransactionColumns.tag_id],
    );
    return qu
        .map((json) => json[TransactionColumns.tag_id].toString())
        .toList();
  }

  Future<List<Transaction>> ofCustomerDuring(
    String customerID,
    TimeInterval targetInterval,
  ) async {
    final assignmentRepo = TagAssignmentRepo(onchanged: null);
    final assignments =
        (await assignmentRepo.assignmentsByCustomer(
          customerID: customerID,
        )).where(
          (assignment) {
            return assignment.interval.intersects(targetInterval);
          },
        ).toList();
    final result = List<Transaction>.empty(growable: true);
    for (final assignment in assignments) {
      final transactionsOfAssignment = await queryAsObjects(
        where:
            '''
${TransactionColumns.tag_id} = ? AND
${TransactionColumns.start} BETWEEN ? AND ?
''',
        whereArgs: [
          assignment.tagID,
          assignment.from.toIso8601String(),
          assignment.toOrNow.toIso8601String(),
        ],
      );
      result.addAll(
        transactionsOfAssignment.where(
          (transaction) {
            return transaction.interval.intersects(targetInterval);
          },
        ),
      );
    }

    return [];
  }
}

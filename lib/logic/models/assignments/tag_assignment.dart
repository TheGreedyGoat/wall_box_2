import 'package:wall_box_2/logic/helpers/interval.dart';
import 'package:wall_box_2/logic/models/assignments/assignment.dart';
import 'package:wall_box_2/logic/models/assignments/price_assignment.dart';
import 'package:wall_box_2/logic/models/customer.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

class TagAssignment extends Assignment {
  final String tagID;
  final String? tagName;

  final Customer customer;

  Interval get interval => Interval(
    from: from,
    to: to ?? DateTime.now(),
  );
  const TagAssignment({
    required this.tagID,
    required this.customer,
    this.tagName,
    required super.from,
    super.to,
  });

  bool matchTransaction(Transaction ta) =>
      ta.tagID == tagID && interval.containsDate(ta.start);

  bool overlapsPriceAssignment(PriceAssignment pa) =>
      pa.customer.id == this.customer.id &&
      pa.interval.intersects(this.interval);
}

import 'package:wall_box_2/logic/helpers/units/euro.dart';
import 'package:wall_box_2/logic/models/assignments/assignment.dart';
import 'package:wall_box_2/logic/models/customer.dart';

class PriceAssignment extends Assignment {
  final Customer customer;
  final Euro price;

  DateTime get toOrNow => to ?? DateTime.now();

  const PriceAssignment({
    required this.customer,
    required this.price,
    required super.from,
    super.to,
  });
}

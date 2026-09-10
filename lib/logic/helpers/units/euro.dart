import 'package:wall_box_2/logic/helpers/units/unit.dart';

class Euro extends Unit {
  @override
  final int value;

  const Euro(this.value);

  @override
  int get defaultPrecision => 2;

  @override
  int get factor => 10000;

  @override
  String get symbol => '€';
}

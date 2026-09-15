import 'package:freezed_annotation/freezed_annotation.dart';
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

/// JSPN Converter for [KiloWattHour]
class EuroJsonConverter extends JsonConverter<Euro, int> {
  /// JSPN Converter for [KiloWattHour]
  const EuroJsonConverter();
  @override
  Euro fromJson(int value) => Euro(value);

  @override
  int toJson(Euro u) => u.value;
}

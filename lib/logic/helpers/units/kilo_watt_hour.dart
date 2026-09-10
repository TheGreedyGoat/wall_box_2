import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/units/unit.dart';

part 'kilo_watt_hour.g.dart';

@JsonSerializable(converters: [KiloWattHourConverter()])
/// Describes an amount of Power. Stores it's values in [wattHours]
class KiloWattHour extends Unit {
  /// The value in wattHours
  final int wattHours;
  @override
  get value => wattHours;
  @override
  String get symbol => 'kWh';

  @override
  int get factor => 1000;

  /// Describes an amount of Power. Stores it's values in [wattHours]

  /// converts [wattHours] to kWh
  double get kWh => externalValue;

  @override
  int get defaultPrecision => 3;

  const KiloWattHour({required this.wattHours});

  @override
  String toStringAsFixed(int precision) =>
      '${kWh.toStringAsFixed(precision)} $symbol';

  ///
  KiloWattHour operator +(KiloWattHour other) {
    return KiloWattHour(wattHours: wattHours + other.wattHours);
  }

  ///
  KiloWattHour operator -(KiloWattHour other) {
    return KiloWattHour(wattHours: wattHours - other.wattHours);
  }
}

/// JSPN Converter for [KiloWattHour]
class KiloWattHourConverter extends JsonConverter<KiloWattHour, int> {
  /// JSPN Converter for [KiloWattHour]
  const KiloWattHourConverter();
  @override
  KiloWattHour fromJson(int value) => KiloWattHour(wattHours: value);

  @override
  int toJson(KiloWattHour u) => u.value;
}

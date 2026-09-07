import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/units/unit.dart';

part 'kilo_watt_hour.g.dart';

@JsonSerializable(converters: [KiloWattHourConverter()])
/// Describes
class KiloWattHour extends Unit {
  /// The value in wattHours
  final int wattHours;
  @override
  get value => wattHours;
  @override
  String get symbol => 'kWh';

  /// Describes
  const KiloWattHour({required this.wattHours});

  /// converts [wattHours] to kWh
  double get kWh => (wattHours / 1000);

  @override
  int get defaultPrecision => 3;

  @override
  String toStringAsFixed(int precision) =>
      '${kWh.toStringAsFixed(precision)} $symbol';
}

/// JSPN Converter for [KiloWattHour]
class KiloWattHourConverter implements UnitConverter<KiloWattHour> {
  /// JSPN Converter for [KiloWattHour]
  const KiloWattHourConverter();
  @override
  KiloWattHour fromJson(int value) => KiloWattHour(wattHours: value);

  @override
  int toJson(KiloWattHour u) => u.value;
}

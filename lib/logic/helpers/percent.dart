import 'package:freezed_annotation/freezed_annotation.dart';

/// Represents, well, a percentage.
///
/// Uses an int [permille] as internal data
class Percent {
  /// the internal value
  final int permille;

  /// Represents, well, a percentage.
  ///
  /// Uses an int [permille] as internal data
  Percent(this.permille);

  /// returns [target], multiplied by this percentage
  num apply(num target) {
    return target * 1 / permille;
  }

  /// returns [target] with the corresponding percent value added
  num add(num target) => target + apply(target);

  /// conversion to a % double
  double get percent => permille / 10.0;

  @override
  String toString() => '${percent.toStringAsFixed(1)} %';
}

class PercentJSONConverter extends JsonConverter<Percent, int> {
  const PercentJSONConverter();
  @override
  Percent fromJson(int json) => Percent(json);

  @override
  int toJson(Percent object) => object.permille;
}

class PercentJSONConverterNullable extends JsonConverter<Percent?, int?> {
  const PercentJSONConverterNullable();
  @override
  Percent? fromJson(int? json) => json != null ? Percent(json) : null;

  @override
  int? toJson(Percent? object) => object?.permille;
}

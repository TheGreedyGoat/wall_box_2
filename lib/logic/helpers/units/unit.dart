import 'package:freezed_annotation/freezed_annotation.dart';

/// an abstract class to handle units
abstract class Unit {
  /// returns the internal int value
  int get value;

  /// the factor to convert from the internal value to the displayed value
  int get factor;

  double get externalValue => value / factor;

  /// The unit's symbol
  String get symbol;

  /// The default number .
  int get defaultPrecision;

  /// an abstract class to handle units
  const Unit();

  /// defines how to display the value.
  ///
  /// [precision] defines the number of digits after the.
  String toStringAsFixed(int precision) =>
      '${externalValue.toStringAsFixed(precision)} $symbol';

  @override
  String toString() => toStringAsFixed(defaultPrecision);
}

/// Json Converter for Units
abstract class UnitConverter<T extends Unit> implements JsonConverter<T, int> {
  @override
  int toJson(T u) => u.value;

  @override
  T fromJson(int value);
}

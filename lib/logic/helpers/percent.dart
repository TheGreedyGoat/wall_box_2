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

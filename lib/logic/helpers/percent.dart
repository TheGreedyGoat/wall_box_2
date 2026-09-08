class Procent {
  final int permille;

  Procent(this.permille);

  num apply(num target) {
    return target * 1 / permille;
  }

  num add(num target) => target + apply(target);

  double get percent => permille / 10;

  @override
  String toString() => '${percent.toStringAsFixed(1)} %';
}

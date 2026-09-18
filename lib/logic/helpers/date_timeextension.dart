/// Adds a method to get a much nicer DateTime String
extension BetterString on DateTime {
  /// returns a String in the format DD.MM.YYYY
  String toNiceString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString().padLeft(4, '0')}';
  }
}

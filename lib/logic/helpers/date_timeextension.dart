import 'dart:math';

/// Adds a method to get a much nicer DateTime String
extension BetterString on DateTime {
  /// returns a String in the format DD.MM.YYYY
  String toDateOnlyString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.${year.toString().padLeft(4, '0')}';
  }

  String toHoursAndMinutesString() {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  String toDynamicString(String pattern) {
    pattern = _replacePattern(pattern, char: 'D', replace: day.toString());
    pattern = _replacePattern(pattern, char: 'M', replace: month.toString());
    pattern = _replacePattern(pattern, char: 'Y', replace: year.toString());
    pattern = _replacePattern(pattern, char: 'h', replace: hour.toString());
    pattern = _replacePattern(pattern, char: 'm', replace: minute.toString());
    pattern = _replacePattern(pattern, char: 's', replace: second.toString());
    return pattern;
  }

  String _replacePattern(
    String pattern, {
    required String char,
    required String replace,
  }) {
    final RegExp regexp = RegExp('$char+');
    final matches = regexp
        .allMatches(pattern)
        .where(
          (element) => element.group(0) != null,
        )
        .toList();
    matches.sort(
      (a, b) {
        return -(a.group(0)!.length.compareTo(b.group(0)!.length));
      },
    );

    for (final match in matches) {
      final m = match.group(0)!;
      final lastIndex = replace.length;
      final firstIndex = max(0, lastIndex - m.length);
      pattern = pattern.replaceAll(
        m,
        replace.substring(firstIndex, lastIndex).padLeft(m.length, '0'),
      );
    }

    return pattern;
  }
}

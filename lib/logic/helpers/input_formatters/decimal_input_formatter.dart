import 'package:flutter/services.dart';

/// A formatter for decimal numbers with a fixed number of fraction digits.
///
/// Supports , and . as separation
class DecimalInputFormatter extends TextInputFormatter {
  /// The max number of fraction digits allowed
  final int fractionDigits;

  /// A formatter for decimal numbers with a fixed number of fraction digits.
  ///
  /// Supports , and . as separation
  DecimalInputFormatter({this.fractionDigits = 2});
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll(',', '.');
    final regExp = RegExp(
      r'^-?\d*\.?\d{0,' + fractionDigits.toString() + r'}$',
    );

    // 4. Prüfe, ob der Text dem Muster entspricht
    if (regExp.hasMatch(text)) {
      // 5. Falls der originale Text ein Komma hatte, behalte es bei
      if (newValue.text.contains(',') && !newValue.text.contains('.')) {
        return newValue;
      }
      // 6. Falls der Text einen Punkt hat, ersetze ihn durch ein Komma (optional)
      //    (Falls du immer Komma als Trennzeichen möchtest)
      //    return TextEditingValue(
      //      text: text.replaceAll('.', ','),
      //      selection: newValue.selection,
      //    );
      return newValue;
    }

    // 7. Falls ungültig: Behalte den alten Wert
    return oldValue;
  }
}

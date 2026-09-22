import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';

/// Just a button that opens the date picker.
/// passes the selected date to onSelected()
class DateButton extends StatefulWidget {
  /// The earliest date to pick
  final DateTime firstDate;

  /// The latest date to pick
  final DateTime lastDate;

  /// what to do with the selected date?
  final void Function(DateTime date) onSelected;

  /// What should be displayed if no date is selected yet?
  ///
  /// defaults to 'DD.MM.YYYY'
  final String? notSelectedLabel;

  /// enable/ disable this button
  final bool enabled;

  /// Just a button that opens the date picker.
  /// passes the selected date to onSelected()
  const DateButton({
    super.key,
    required this.firstDate,
    required this.lastDate,
    required this.onSelected,
    this.notSelectedLabel,
    this.enabled = true,
  });

  @override
  State<DateButton> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  DateTime? selected;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(4.0),
        ),
      ),
      onPressed: widget.enabled
          ? () async {
              final date = await showDatePicker(
                context: context,
                firstDate: widget.firstDate,
                lastDate: widget.lastDate,
              );
              if (date != null) {
                widget.onSelected(date);
                selected = date;
              }
            }
          : null,
      child: Text(
        selected?.toDateOnlyString() ?? widget.notSelectedLabel ?? 'DD.MM.YYYY',
      ),
    );
  }
}

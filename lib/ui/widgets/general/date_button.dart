import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';

class DateButton extends StatefulWidget {
  final DateTime firstDate, lastDate;
  final void Function(DateTime date) onSelected;
  final String? notSelectedLabel;
  final bool enabled;
  DateButton({
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
        selected?.toNiceString() ?? widget.notSelectedLabel ?? 'DD.MM.YYYY',
      ),
    );
  }
}

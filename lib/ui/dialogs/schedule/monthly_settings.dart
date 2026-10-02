import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/widgets/general/text_form_fields/text_form_field_digits.dart';

class MonthlySettings extends StatefulWidget {
  const MonthlySettings({super.key});

  @override
  State<MonthlySettings> createState() => _MonthlySettingsState();
}

class _MonthlySettingsState extends State<MonthlySettings> {
  Set<int> dates = {};
  bool ensureWorkday = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            IntrinsicWidth(
              child: CheckboxListTile(
                value: dates.contains(1),
                title: Text(
                  'zum 1. des Monats',
                ),
                onChanged: (value) {
                  setState(() {
                    value == true ? dates.add(1) : dates.remove(1);
                  });
                },
              ),
            ),
            IntrinsicWidth(
              child: CheckboxListTile(
                value: dates.contains(15),
                title: Text('zum 15. des Monats'),

                onChanged: (value) {
                  setState(() {
                    value == true ? dates.add(15) : dates.remove(15);
                  });
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            IntrinsicWidth(
              child: CheckboxListTile(
                value: ensureWorkday,
                title: Text('immer werktags'),

                onChanged: (value) {
                  setState(() {
                    ensureWorkday = value!;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

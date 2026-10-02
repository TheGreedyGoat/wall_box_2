import 'package:flutter/material.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';
import 'package:wall_box_2/ui/dialogs/dialog_scaffold.dart';
import 'package:wall_box_2/ui/dialogs/schedule/monthly_settings.dart';
import 'package:wall_box_2/ui/widgets/general/buttons/date_button.dart';

Future<void> showScheduleDialog(
  BuildContext context, [
  Set<ScheduleOption>? excludeOptions,
]) async {
  await showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(10),
      ),
      child: SizedBox(
        // width: 200,
        // height: 200,
        child: ScheduleDialog(
          excludeOptions: excludeOptions,
        ),
      ),
    ),
  );
}

class ScheduleDialog extends StatefulWidget {
  final Set<ScheduleOption>? excludeOptions;
  const ScheduleDialog({super.key, this.excludeOptions});

  @override
  State<ScheduleDialog> createState() => _ScheduleDialogState();
}

class _ScheduleDialogState extends State<ScheduleDialog> {
  late final List _options;
  DateTime? selectedStart;
  DateTime? selectedEnd;

  ScheduleOption _scheduleOption = ScheduleOption.monthly;

  @override
  void initState() {
    super.initState();
    _options = ScheduleOption.values.where(
      (element) {
        return !(widget.excludeOptions?.contains(element) ?? false);
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DialogScaffold(
      title: 'Terminwiederholung auswählen oder so',

      child: IntrinsicHeight(
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Head: begin/  end
            SizedBox(
              width: 250,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Beginn'),
                        DateButton(
                          initialDate: selectedStart,
                          tooltip: 'Ab wann?',
                          firstDate: DateTime.now()
                              .subtract(Duration(days: 730))
                              .dateOnly(),
                          lastDate: DateTime.now()
                              .add(Duration(days: 730))
                              .dateOnly(),
                          onSelected: (date) {},
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      spacing: 10,
                      children: [
                        Text('Ende'),
                        DateButton(
                          tooltip: 'Bis wann?',
                          firstDate: DateTime.now()
                              .subtract(Duration(days: 730))
                              .dateOnly(),
                          lastDate: DateTime.now()
                              .add(Duration(days: 730))
                              .dateOnly(),
                          onSelected: (date) {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // daily, weekly,..., settings
            Divider(),
            Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: RadioGroup<ScheduleOption>(
                    groupValue: _scheduleOption,
                    onChanged: (value) {
                      setState(() {
                        _scheduleOption = value ?? _scheduleOption;
                      });
                    },
                    child: Column(
                      children: [
                        ..._options.map(
                          (e) => RadioListTile<ScheduleOption>(
                            value: e,
                            title: Text(e.toString().split('.').last),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                VerticalDivider(),

                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.fromLTRB(
                      left: BorderSide(
                        width: 3,
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    // color: Colors.green,
                  ),
                  child: MonthlySettings(),
                ),
              ],
            ),
            Divider(),
            // confirm etc.
            Row(
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

enum ScheduleOption { daily, weekly, monthly }

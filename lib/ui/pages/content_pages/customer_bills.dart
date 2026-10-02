import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:my_utils/utility/enums/months.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/widgets/predecorated/background_card.dart';

class CustomerBills extends StatefulWidget {
  const CustomerBills({super.key});

  @override
  State<CustomerBills> createState() => _CustomerBillsState();
}

class _CustomerBillsState extends State<CustomerBills> {
  TextEditingController ctrlYear = TextEditingController();
  final suggettions = SuggestionsController<int>();
  Month? selectedMonth;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackgroundCard(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                DropdownButton<Month?>(
                  value: selectedMonth,
                  items: [
                    DropdownMenuItem(value: null, child: Text('alle')),
                    ...Month.values.map(
                      (month) => DropdownMenuItem<Month?>(
                        value: month,
                        child: Text(currentLanguage.monthNames[month]!),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
                ),
                SizedBox(
                  width: 200,

                  child: TypeAheadField<int>(
                    controller: ctrlYear,
                    suggestionsController: suggettions,
                    builder: (context, controller, focusNode) {
                      return TextFormField(
                        controller: controller,
                        focusNode: focusNode,
                        onChanged: (value) {
                          // ctrlYear.text = value;
                        },
                      );
                    },
                    itemBuilder: (context, value) {
                      return Text(value.toString());
                    },
                    onSelected: (value) {
                      setState(() {
                        ctrlYear.value = TextEditingValue(
                          text: value.toString(),
                        );
                      });
                    },
                    suggestionsCallback: (search) {
                      final currentYear = DateTime.now().year;
                      final text = ctrlYear.text;
                      final suggestions =
                          [
                            for (int i = 0; i < 10; i++) currentYear - i,
                          ].where(
                            (year) {
                              return year.toString().contains(text);
                            },
                          ).toList();

                      return suggestions;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

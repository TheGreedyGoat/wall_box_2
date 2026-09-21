import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/helpers/input_formatters/decimal_input_formatter.dart';
import 'package:wall_box_2/logic/riverpod/customer_price/price_assignment_edit_notifier.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/decorators/text_field_decoration.dart';
import 'package:wall_box_2/ui/widgets/general/date_button.dart';

/// displays and enables changing tghe customer's individual price
class CustomerPriceDisplay extends ConsumerStatefulWidget {
  /// displays and enables changing tghe customer's individual price
  const CustomerPriceDisplay({super.key});

  @override
  ConsumerState<CustomerPriceDisplay> createState() =>
      _CustomerPriceDisplayState();
}

class _CustomerPriceDisplayState extends ConsumerState<CustomerPriceDisplay> {
  bool editActive = false;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(priceAssignmentEditProvider);
    return editActive ? _edit(state) : _display(state);
  }

  Widget _display(PriceAssignmentEditState state) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        'Aktueller Preis/ kWh: ${state.price?.cents.toStringAsFixed(2) ?? '---'} c/kWh',
      ),
      IconButton(
        onPressed: () => setState(() {
          _controller.text = state.price?.cents.toStringAsFixed(2) ?? '';
          editActive = true;
        }),
        icon: Icon(Icons.edit),
        tooltip: 'ändern',
      ),
    ],
  );

  Widget _edit(PriceAssignmentEditState state) => Row(
    children: [
      Expanded(
        child: TextFormField(
          enabled: editActive,
          inputFormatters: [DecimalInputFormatter()],
          decoration: textFieldDecoration.copyWith(
            labelText: 'Preis (cent/kWh)',
            hintText: 'X,XX',
          ),
          controller: _controller,
        ),
      ),
      DateButton(
        firstDate: state.earliestAvailable,
        lastDate: DateTime.now(),
        onSelected: (date) =>
            ref.read(priceAssignmentEditProvider.notifier).setStartDate(date),
      ),
      if (editActive) ...[
        IconButton(
          onPressed: () {
            setState(() {
              editActive = false;
            });
          },
          icon: Icon(Icons.close),
        ),
      ],
      if (editActive) ...[
        IconButton(
          onPressed: () {
            final centicentText = _controller.text.replaceAll(',', '.');
            double? cents = double.tryParse(centicentText);
            if (cents != null) {
              final centicents = (cents * 100).floor();
              ref
                  .read(priceAssignmentEditProvider.notifier)
                  .setPrice(centicents);
              setState(() {
                editActive = false;
              });
            }
          },
          icon: Icon(Icons.check),
        ),
      ],
    ],
  );
}

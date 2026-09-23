import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/models/data_packs/transaction_data_pack.dart';

/// A tile to display a single transaction's basic data
///
/// used for overviews
class TransactionTile extends ConsumerWidget {
  /// The transactionData to display
  final TransactionDataPack data;

  /// A tile to display a single transaction's basic data
  ///
  /// used for overviews
  const TransactionTile({required this.data, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SizedBox(
        height: 55,
        child: Row(
          spacing: 16,
          children:
              [
                    _tile(
                      context,
                      subtitle: SelectableText(data.transaction.tagID),
                    ),
                    _tile(
                      context,
                      title: SelectableText(data.customerName),
                      subtitle: data.customerData != CustomerDataPackage.unknown
                          ? SelectableText(data.customerData!.id)
                          // this one
                          : TextButton(
                              onPressed: () {},
                              child: Text('Tag zuweisen'),
                            ),
                    ),
                    _tile(
                      context,
                      title: SelectableText(
                        data.transaction.start.toDynamicString('DD.MM.YY'),
                      ),
                      subtitle: SelectableText(
                        '${data.transaction.start.toDynamicString('hh:mm')} - ${data.transaction.stop.toDynamicString('hh:mm')}',
                      ),
                    ),
                    _tile(
                      context,
                      title: SelectableText(data.transaction.usage.toString()),
                      subtitle: Text('kWh'),
                    ),
                  ]
                  .map(
                    (e) => SizedBox(
                      width: 150,
                      child: e,
                    ),
                  )
                  .toList(),
        ),
      ),
    );
  }

  Widget _tile(BuildContext context, {Widget? title, Widget? subtitle}) {
    if (title is Text) {
      title = Text(
        title.data!,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    } else if (title is SelectableText) {
      title = SelectableText(
        title.data!,
        style: TextStyle(fontWeight: FontWeight.bold),
      );
    }
    if (subtitle is Text) {
      subtitle = Text(
        subtitle.data!,
        style: TextStyle(
          color: Theme.of(context).disabledColor,
          fontWeight: FontWeight.bold,
        ),
      );
    } else if (subtitle is SelectableText) {
      subtitle = SelectableText(
        subtitle.data!,
        style: TextStyle(
          color: Theme.of(context).disabledColor,
          fontWeight: FontWeight.bold,
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [title ?? Text(''), subtitle ?? Text('')],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_utils/utility/class_extensions/date_time_extensions.dart';
import 'package:wall_box_2/logic/helpers/enums/billing_status.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/models/data_packs/transaction_data_pack.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/dialogs/assign_tag_dialog.dart';
import 'package:wall_box_2/ui/widgets/general/buttons/copy_button.dart';
import 'package:wall_box_2/ui/widgets/general/list_tile_row.dart';

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
    return ListTileRow(
      entries: [
        ListTileRowEntry(
          title: SelectableText(data.customerName),
        ),
        ListTileRowEntry(
          title: SelectableText(
            data.transaction.start.toDynamicString('~DD.~MM.~YY'),
          ),
          subtitle: SelectableText(
            '${data.transaction.start.toDynamicString('~hh:~mm')} - ${data.transaction.stop.toDynamicString('~hh:~mm')}',
          ),
        ),
        ListTileRowEntry(
          title: SelectableText(data.transaction.usage.toString()),
          subtitle: Text('kWh'),
        ),
        ListTileRowEntry(
          title: () {
            final status = data.transaction.status;
            return Card(
              color: Color.lerp(
                Colors.white,
                status.baseColor,
                0.55,
              ),
              // decoration: BoxDecoration(
              // ),
              shape: StadiumBorder(),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                  ),
                  child: Text(
                    switch (data.transaction.status) {
                      BillingStatus.open => 'offen',
                      BillingStatus.billed => 'fertig',
                    },
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: status.foreGroundColor,
                    ),
                  ),
                ),
              ),
            );
          }(),
        ),
        ListTileRowEntry(
          title: data.customerData == CustomerDataPackage.unknown
              ? TextButton(
                  onPressed: () async {
                    await showAssignmentDialog(
                      context,
                      data.tagID,
                      initialDate: data.transaction.start,
                    );
                    await ref.read(customerEditProvider.notifier).load();
                  },
                  child: Text('Tag zuweisen'),
                )
              : null,
          subtitle: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(data.transaction.tagID),
              SizedBox.square(
                dimension: 20,
                child: CopyButton(
                  size: 20,
                  getData: () => data.transaction.tagID,
                  dataDescription: 'Tag-ID',
                ),
              ),
            ],
          ),
        ),
      ],
      widthPerTile: 200,
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

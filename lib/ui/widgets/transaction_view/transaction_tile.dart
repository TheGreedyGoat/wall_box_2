import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';
import 'package:wall_box_2/logic/models/data_packs/transaction_data_pack.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

class TransactionTile extends ConsumerWidget {
  final TransactionDataPack data;
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
                    tile(subtitle: SelectableText(data.transaction.tagID)),
                    tile(
                      title: SelectableText(data.customerName),
                      subtitle: SelectableText(data.customer?.id ?? ''),
                    ),
                    tile(
                      title: SelectableText(
                        data.transaction.start.toDynamicString('DD.MM.YY'),
                      ),
                      subtitle: SelectableText(
                        '${data.transaction.start.toDynamicString('hh:mm')} - ${data.transaction.stop.toDynamicString('hh:mm')}',
                      ),
                    ),
                    tile(
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

  Widget tile({Widget? title, Widget? subtitle}) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [title ?? Text(''), subtitle ?? Text('')],
  );
}

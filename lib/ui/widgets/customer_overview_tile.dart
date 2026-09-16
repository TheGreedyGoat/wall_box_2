import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/logic/models/master_data/customer/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/pages/enter_customer_data.dart';

class CustomerOverviewTile extends ConsumerWidget {
  final CustomerDataPackage data;
  const CustomerOverviewTile({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        title: SelectableText(
          data.displayName,
        ),
        subtitle: SelectableText('#${data.id}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () =>
                      toCustomerView(ref: ref, context: context, data: data),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.edit),
                      Text(currentLanguage.edit),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: () {
                    _confirmDeletion(context, ref);
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.delete),
                      Text(currentLanguage.delete),
                    ],
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                toCustomerView(ref: ref, context: context, data: data);
              },
              icon: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDeletion(BuildContext context, WidgetRef ref) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(Icons.dangerous),
          content: Text(
            'Sind Sie sicher, dass sie Kunde ${data.displayName} und alle zugehörigen Daten löschen wollen?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('löschen'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('abbrechen'),
            ),
          ],
        );
      },
    );
    if (!(confirm ?? false)) return;
    ref
        .read(customerRepoProvider)
        .delete(
          where: '${CustomerColumns.id} = ?',
          whereArgs: [data.id],
        );
  }
}

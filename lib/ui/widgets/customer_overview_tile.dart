import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/confirm_action_dialog.dart';
import 'package:wall_box_2/ui/language/language.dart';

/// displays a customer's basic informations
///
/// clicking sets the main customer page to display [data]
class CustomerOverviewTile extends ConsumerWidget {
  /// The corresponding customer's data
  final CustomerDataPackage data;

  /// displays a customer's basic informations
  ///
  /// clicking sets the main customer page to display [data]
  const CustomerOverviewTile({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isSelected = ref.watch(customerEditProvider).data == data;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(8.0),
        side: isSelected ? BorderSide() : BorderSide.none,
      ),
      child: ListTile(
        onTap: () {
          ref.read(customerEditProvider.notifier).load(data.id);
        },
        title: Text(
          data.displayName,
        ),
        subtitle: IntrinsicWidth(child: Text('# ${data.id}')),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () =>
                      ref.read(customerEditProvider.notifier).load(data.id),
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
            // IconButton(
            //   onPressed: () {

            //   },
            //   icon: Icon(Icons.chevron_right),
            // ),
          ],
        ),
      ),
    );
  }

  void _confirmDeletion(BuildContext context, WidgetRef ref) async {
    showConfirmationDialog(
      context: context,
      onConfirm: () {
        ref
            .read(customerRepoProvider)
            .delete(
              where: '${CustomerColumns.id} = ?',
              whereArgs: [data.id],
            );
      },
      onCancel: () {},
      content: Text(
        'Sind Sie sicher, dass sie Kunde ${data.displayName} und alle zugehörigen Daten löschen wollen?',
      ),
      title: Text('Löschen bestätigen'),
      icon: Icon(Icons.delete_forever),
    );
  }
}

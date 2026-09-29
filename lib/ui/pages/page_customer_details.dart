import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/logic/models/data_packs/customer_data_package.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/confirm_action_dialog.dart';
import 'package:wall_box_2/ui/language/language.dart';
import 'package:wall_box_2/ui/pages/split_page.dart';
import 'package:wall_box_2/ui/widgets/customer_tiles/customer_overview_tile.dart';
import 'package:wall_box_2/ui/widgets/customer_view/customer_overview.dart';
import 'package:wall_box_2/ui/widgets/customer_view/master_data/enter_customer_data.dart';

/// Main page for the customer view
class PageCustomerDetails extends ConsumerWidget {
  /// Main page for the customer view
  const PageCustomerDetails({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SplitPage(
      left: CustomerOverview(
        appBarTitle: Text('Kundenübersicht'),
        appBarActions: [
          IconButton(
            onPressed: () async {
              ref.read(selectedCustomerDataProvider.notifier).data = null;
              // await ref.read(customerEditProvider.notifier).load();
            },
            icon: Icon(Icons.person_add),
            tooltip: 'Neuen Kunden anlegen',
          ),
        ],
        onTileTap: (data) {
          ref.read(selectedCustomerDataProvider.notifier).data = data;
        },
        actionsBuilder: (data) {
          return [
            PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () =>
                      ref.read(selectedCustomerDataProvider.notifier).data =
                          data,
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
                    _confirmDeletion(context, ref, data);
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
          ];
        },
        noCustomerWidget: Text('Keine Kunden gefunden'),
      ),
      right: EnterCustomerData(),
    );
  }

  void _confirmDeletion(
    BuildContext context,
    WidgetRef ref,
    CustomerDataPackage data,
  ) async {
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

import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/widgets/general/list_tile_row.dart';
import 'package:wall_box_2/ui/widgets/transaction_view/import_file_button.dart';

class TransactionHeadCard extends StatefulWidget {
  const TransactionHeadCard({super.key});

  @override
  State<TransactionHeadCard> createState() => _TransactionHeadCardState();
}

class _TransactionHeadCardState extends State<TransactionHeadCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTileRow(
        entries: [
          ListTileRowEntry(
            title: Text('Kunde'),
            subtitle: Text('Kundenkennung'),
          ),
          ListTileRowEntry(
            title: Text('Datum'),
            subtitle: Text('Uhrzeit von-bis'),
          ),
          ListTileRowEntry(
            title: Text('Verbrauch'),
          ),
          ListTileRowEntry(
            title: Text('Status'),
          ),
          ListTileRowEntry(
            title: Text('Tag ID'),
          ),
        ],
        widthPerTile: 200,
      ),
    );
  }
}

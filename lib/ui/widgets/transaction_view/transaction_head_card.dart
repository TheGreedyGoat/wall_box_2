import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Tooltip(
              message: 'Transaktionen suchen',
              child: SearchBar(
                constraints: BoxConstraints(maxWidth: 300, minHeight: 50),
                trailing: [
                  IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                ],
              ),
            ),
          ),
          ImportFileButton(),
        ],
      ),
    );
  }
}

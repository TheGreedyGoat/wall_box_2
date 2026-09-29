import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/models/transaction.dart';

/// Test Widget. Displays a transaction block ina condensed way
class TaBlockDisplay extends StatefulWidget {
  /// The Transaction block to display
  final Transaction transaction;

  /// Test Widget. Displays a transaction block ina condensed way
  const TaBlockDisplay({super.key, required this.transaction});

  @override
  State<TaBlockDisplay> createState() => _TaBlockDisplayState();
}

class _TaBlockDisplayState extends State<TaBlockDisplay> {
  Transaction get transaction => widget.transaction;

  bool extended = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        spacing: 4.0,
        children: [
          ListTile(
            tileColor: Colors.brown[300],
            leading: Text('Start'),
            title: Text(
              transaction.start.toString(),
              // block.start?.timeStamp.toString() ?? 'ERROR',
            ),
            subtitle: Text(
              transaction.usage.toStringAsFixed(3),
              // block.start?.powerLevelWh.toString() ?? 'ERROR',
            ),
            trailing: Text(transaction.tagID),
          ),
        ],
      ),
    );
  }
}

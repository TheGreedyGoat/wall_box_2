import 'package:flutter/material.dart';
import 'package:wall_box_2/logic/parser/wall_box_log.dart';
import 'package:wall_box_2/logic/parser/wall_box_transaction_block/wall_box_transaction_block.dart';

class TaBlockDisplay extends StatefulWidget {
  final WallBoxTransactionBlock block;
  const TaBlockDisplay({super.key, required this.block});

  @override
  State<TaBlockDisplay> createState() => _TaBlockDisplayState();
}

class _TaBlockDisplayState extends State<TaBlockDisplay> {
  WallBoxTransactionBlock get block => widget.block;

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
              block.start?.timeStamp.toString() ?? 'ERROR',
            ),
            subtitle: Text(
              block.start?.powerLevelWh.toString() ?? 'ERROR',
            ),
            trailing: Row(
              spacing: 4.0,
              mainAxisSize: MainAxisSize.min,
              children: [Text(block.tagID ?? 'ERROR'), _extensionButton(true)],
            ),
          ),
          if (extended)
            ...block.mvLines.map(
              (mv) => Padding(
                padding: const EdgeInsetsGeometry.only(left: 16.0),

                child: ListTile(
                  tileColor: Colors.brown[200],
                  leading: Text('MV'),
                  title: Text(
                    mv.timeStamp.toString(),
                  ),
                  subtitle: Text(
                    mv.powerLevelWh.toString(),
                  ),
                ),
              ),
            ),
          ListTile(
            tileColor: Colors.brown[300],
            leading: Text('Stop'),
            title: Text(
              block.start?.timeStamp.toString() ?? 'ERROR',
            ),
            subtitle: Text(
              block.start?.powerLevelWh.toString() ?? 'ERROR',
            ),
            trailing: Row(
              spacing: 4.0,
              mainAxisSize: MainAxisSize.min,
              children: [Text(block.tagID ?? 'ERROR'), _extensionButton(false)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _extensionButton(bool start) => IconButton(
    onPressed: () => setState(() {
      extended = !extended;
    }),
    icon: Icon(
      extended
          ? (start
                ? Icons.keyboard_arrow_down_rounded
                : Icons.keyboard_arrow_up_rounded)
          : Icons.keyboard_arrow_right_rounded,
    ),
  );
}

import 'package:flutter/material.dart';

class ListTileRow extends StatelessWidget {
  final List<ListTileRowEntry> entries;
  final double widthPerTile;
  final EdgeInsetsGeometry padding;
  const ListTileRow({
    super.key,
    required this.entries,
    required this.widthPerTile,
    this.padding = const EdgeInsets.symmetric(horizontal: 8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (final e in entries) ...[
            SizedBox(
              width: widthPerTile,
              child: e,
            ),
          ],
        ],
        // entries
        //     .map(
        //       (e) => SizedBox(
        //         width: widthPerTile,
        //         child: e,
        //       ),
        //     )
        //     .toList(),
      ),
    );
  }
}

class ListTileRowEntry extends StatelessWidget {
  final Widget? title;
  final Widget? subtitle;

  const ListTileRowEntry({super.key, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    final usedTitle = title is Text
        ? Text(
            (title as Text).data!,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        : title is SelectableText
        ? SelectableText(
            (title as SelectableText).data!,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        : title;

    final usedSubtitle = subtitle is Text
        ? Text(
            (subtitle as Text).data!,
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold,
            ),
          )
        : subtitle is SelectableText
        ? SelectableText(
            (subtitle as SelectableText).data!,
            style: TextStyle(
              color: Theme.of(context).disabledColor,
              fontWeight: FontWeight.bold,
            ),
          )
        : subtitle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [usedTitle ?? Text(''), usedSubtitle ?? Text('')],
    );
  }
}

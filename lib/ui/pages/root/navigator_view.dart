import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/pages/root/navigation_item.dart';

class NavigatorView extends StatefulWidget {
  final List<NavigationItem> items;
  final Widget Function(BuildContext context, NavigationItem item) itemBuilder;
  final Widget Function(BuildContext context, List<Widget> itemWidgets)
  viewBuilder;

  final void Function(NavigationItem item) onTap;
  const NavigatorView({
    super.key,
    required this.items,
    required this.itemBuilder,
    required this.viewBuilder,
    required this.onTap,
  });

  @override
  State<NavigatorView> createState() => _NavigatorViewState();
}

class _NavigatorViewState extends State<NavigatorView> {
  @override
  Widget build(BuildContext context) {
    return widget.viewBuilder(
      context,
      widget.items.map(
        (item) {
          return InkWell(
            onTap: () {
              widget.onTap(item);
            },
            child: widget.itemBuilder(context, item),
          );
        },
      ).toList(),
    );
  }
}

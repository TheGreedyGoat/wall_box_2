import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/ui/pages/main_pages/page_customer_details.dart';
import 'package:wall_box_2/ui/pages/root/navigation_item.dart';
import 'package:wall_box_2/ui/pages/root/navigation_notifier.dart';
import 'package:wall_box_2/ui/pages/root/navigator_view.dart';

class LeftNavigationBar extends ConsumerStatefulWidget {
  final List<NavigationItem> items;
  const LeftNavigationBar({super.key, required this.items});

  @override
  ConsumerState<LeftNavigationBar> createState() => _LeftNavigationBarState();
}

class _LeftNavigationBarState extends ConsumerState<LeftNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationProvider);
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: NavigatorView(
              items: widget.items,
              itemBuilder: (context, item) {
                bool isSelected = widget.items.indexOf(item) == selectedIndex;
                return ListTile(
                  mouseCursor: SystemMouseCursors.click,

                  tileColor: isSelected ? Colors.indigo : null,
                  leading: item.icon,
                  title: Text(item.title),
                );
              },
              viewBuilder: (context, itemWidgets) {
                return ListView(children: itemWidgets);
              },

              onTap: (item) {
                ref
                    .read(navigationProvider.notifier)
                    .setState(widget.items.indexOf(item));
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Einstellungen'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

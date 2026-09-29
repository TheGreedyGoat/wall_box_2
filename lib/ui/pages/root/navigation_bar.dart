import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/ui/pages/root/navigation_notifier.dart';

class LeftNavigationBar extends ConsumerStatefulWidget {
  const LeftNavigationBar({super.key});

  @override
  ConsumerState<LeftNavigationBar> createState() => _LeftNavigationBarState();
}

class _LeftNavigationBarState extends ConsumerState<LeftNavigationBar> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: _button(-1, Icons.javascript, 'einklappen')),
        SizedBox(
          height: 10,
        ),
        Column(
          children: [
            _button(0, Icons.person, 'Kunden'),
            _button(1, Icons.power, 'Transaktionen'),
          ],
        ),
      ],
    );
  }

  Widget _button(int index, IconData icon, String label) => InkWell(
    onTap: () => _setPage(index),
    child: Container(
      color: ref.watch(navigationProvider) == index ? Colors.blue : null,
      child: SizedBox(
        width: expanded ? 200 : 80,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 35,
            ),
            ?(expanded
                ? Text(
                    label,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                : null),
          ],
        ),
      ),
    ),
  );
  // ElevatedButton(
  //   onPressed: () => _setPage(1),
  //   child: Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [Icon(icon), Text(label)],
  //   ),
  // );

  void _setPage(int index) {
    if (index < 0) {
      setState(() {
        expanded = !expanded;
      });
      return;
    }
    ref.watch(navigationProvider.notifier).setState(index);
  }
}

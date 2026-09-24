import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wall_box_2/ui/pages/page_customer_details.dart';
import 'package:wall_box_2/ui/pages/page_transaction_overview.dart';

class WidgetTreeRoot extends StatefulWidget {
  const WidgetTreeRoot({super.key});

  @override
  State<WidgetTreeRoot> createState() => _WidgetTreeRootState();
}

class _WidgetTreeRootState extends State<WidgetTreeRoot> {
  int selectedPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedPageIndex](),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: (value) {
          setState(() {
            selectedPageIndex = max(
              0,
              min(_pages.length - 1, value),
            );
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'bla'),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'bla'),
        ],
      ),
    );
  }

  final List<Widget Function()> _pages = [
    () => PageCustomerDetails(),
    () => PageTransactionOverview(),
  ];
}

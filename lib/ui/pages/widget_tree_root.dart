import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/pages/page_customer_details.dart';
import 'package:wall_box_2/ui/pages/page_transaction_overview.dart';
import 'package:wall_box_2/ui/widgets/general/color_picker_button.dart';

class WidgetTreeRoot extends ConsumerStatefulWidget {
  const WidgetTreeRoot({super.key});

  @override
  ConsumerState<WidgetTreeRoot> createState() => _WidgetTreeRootState();
}

class _WidgetTreeRootState extends ConsumerState<WidgetTreeRoot> {
  int selectedPageIndex = 0;
  bool isdark = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            await AppDatabase.instance.delete();
            ref.read(changeProvider.notifier).reset();
            print('done');
          },
          tooltip: 'Clear all evidence MUHAHAHA',
          icon: Icon(Icons.delete_forever_sharp),
        ),
        title: Text('HIGHLY TEMPORARY DEV APPBAR'),
        actions: [
          ColorPickerButton(
            initialColor: ref.read(themeProvider).colorSeed,
            onSubmit: (color) {
              ref.read(themeProvider).setColorSeed(color);
            },
          ),
          Switch(
            value: isdark,
            onChanged: (value) {
              setState(() {
                isdark = value;
                ref.read(themeProvider.notifier).toggleDarkMode(value);
              });
            },
          ),
        ],
      ),
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
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Kunden'),
          BottomNavigationBarItem(
            icon: Icon(Icons.power),
            label: 'Transaktionen',
          ),
        ],
      ),
    );
  }

  final List<Widget Function()> _pages = [
    () => PageCustomerDetails(),
    () => PageTransactionOverview(),
  ];
}

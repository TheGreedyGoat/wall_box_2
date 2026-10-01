import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wall_box_2/data/database/core/app_database.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:wall_box_2/ui/pages/main_pages/page_customer_details.dart';
import 'package:wall_box_2/ui/pages/main_pages/page_transaction_overview.dart';
import 'package:wall_box_2/ui/pages/root/navigation_bar.dart';
import 'package:wall_box_2/ui/pages/root/navigation_notifier.dart';
import 'package:wall_box_2/ui/widgets/general/buttons/color_picker_button.dart';

class WidgetTreeRoot extends ConsumerStatefulWidget {
  const WidgetTreeRoot({super.key});

  @override
  ConsumerState<WidgetTreeRoot> createState() => _WidgetTreeRootState();
}

class _WidgetTreeRootState extends ConsumerState<WidgetTreeRoot> {
  bool isdark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        leading: IconButton(
          onPressed: () async {
            await AppDatabase.instance.delete();
            ref.read(changeProvider.notifier).reset();
          },
          tooltip: 'Clear all evidence MUHAHAHA',
          icon: Icon(Icons.delete_forever_sharp),
        ),
        title: Text('HIGHLY TEMPORARY DEV APPBAR'),
        actions: [
          ColorPickerButton(
            onSubmit: (color) {
              ref.read(themeProvider.notifier).setColorSeed(color);
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
      body: Row(
        children: [
          LeftNavigationBar(
            items: pageMainDestinations,
          ),
          Expanded(
            child: pageMainDestinations
                .elementAt(ref.watch(navigationProvider))
                .destination,
          ),
        ],
      ),
    );
  }
}

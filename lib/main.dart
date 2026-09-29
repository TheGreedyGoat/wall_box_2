import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/riverpod/providers.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:wall_box_2/ui/pages/root/widget_tree_root.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  // await AppDatabase.instance.delete();
  runApp(ProviderScope(child: MainApp()));
}

///
class MainApp extends ConsumerWidget {
  ///
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ref.watch(themeProvider).themeData,
      home: WidgetTreeRoot(),
    );
  }
}

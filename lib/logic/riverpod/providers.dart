import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wall_box_2/logic/riverpod/customer_edit/customer_edit_notifier.dart';

final customerEditProvider = NotifierProvider(
  () => CustomerEditNotifier(),
);

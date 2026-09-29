import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationNotifier extends Notifier<int> {
  @override
  int build() => 0;

  setState(int value) => state = value;
}

final navigationProvider = NotifierProvider(() => NavigationNotifier());

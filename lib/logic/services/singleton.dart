import 'package:wall_box_2/logic/services/parser_service.dart';

abstract class Singleton<T> {
  static List<Singleton> _instances = List.empty(growable: true);

  static Singleton? getInstanceOfType(Type V) {
    try {
      return _instances.firstWhere(
        (inst) {
          return inst.runtimeType == V;
        },
      );
    } catch (e) {
      final newInst = switch (V) {
        const (ParserService) => ParserService(),
        _ => null,
      };
      if (newInst != null) {
        _instances.add(newInst);
        return newInst as Singleton;
      }
      return null;
    }
  }
}

import 'package:wall_box_2/logic/services/parser/wall_box_parser.dart';

/// parent class for Singletons.
///
/// The class can store one instance per Singleton subtype.
///
/// Acces using getInstanceOfType(V) (V has to be a Singleton subtype)
///
/// ## Caution!
///  When creating new implementations,
///  add the implementation's type into the getInstancOfType logic
///
abstract class Singleton<T> {
  static final List<Singleton> _instances = List.empty(growable: true);

  /// Creates a new Instance of V if there is none saved already and saves it.
  ///
  /// finally returns the instance.
  ///
  ///
  /// ## Caution!
  ///  When creating new implementations,
  ///  add the implementation's type into the getInstancOfType logic
  ///
  static Singleton? getInstanceOfType(Type V) {
    try {
      return _instances.firstWhere(
        (inst) {
          return inst.runtimeType == V;
        },
      );
    } catch (e) {
      final newInst = switch (V) {
        const (WallBoxParser) => WallBoxParser(),
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

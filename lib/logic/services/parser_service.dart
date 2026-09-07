import 'package:wall_box_2/logic/services/singleton.dart';

class ParserService implements Singleton<ParserService> {
  static ParserService? _instance;

  @override
  ParserService get instance {
    _instance = _instance ?? ParserService();
    return _instance!;
  }
}

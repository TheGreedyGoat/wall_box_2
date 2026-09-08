import 'package:wall_box_2/logic/services/singleton.dart';

class ParserService implements Singleton<ParserService> {
  static ParserService get instance =>
      Singleton.getInstanceOfType(ParserService) as ParserService;
}

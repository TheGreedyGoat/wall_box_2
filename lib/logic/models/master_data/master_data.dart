import 'package:wall_box_2/logic/helpers/data_error.dart';

abstract class MasterData {
  MasterData();

  List<DataError?> get validationList;
  List<DataError> validate() => validationList.whereType<DataError>().toList();
}

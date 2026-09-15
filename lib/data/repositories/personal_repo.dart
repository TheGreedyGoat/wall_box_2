import 'package:json_annotation/src/json_converter.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';

class PersonalRepo extends Repository<PersonalData> {
  @override
  String get tableName => TableNames.personal;

  @override
  PersonalDataJsonConverter get converter => PersonalDataJsonConverter();
}

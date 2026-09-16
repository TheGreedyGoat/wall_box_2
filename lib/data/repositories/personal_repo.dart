import 'package:json_annotation/src/json_converter.dart';
import 'package:wall_box_2/data/database/tables/personal_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/personal/personal_data.dart';

class PersonalRepo extends Repository<PersonalData> {
  PersonalRepo({required super.onchanged});

  @override
  String get tableName => TableNames.personal;

  @override
  PersonalDataJsonConverter get converter => PersonalDataJsonConverter();

  Future<PersonalData?> getById(String customerID) async =>
      await get('${PersonalColumns.customer_id} = ?', [customerID]);
}

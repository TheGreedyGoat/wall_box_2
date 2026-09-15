import 'package:json_annotation/src/json_converter.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';

class CompanyRepo extends Repository<CompanyData> {
  @override
  String get tableName => TableNames.company;

  @override
  CompanyDataJsonConverter get converter => CompanyDataJsonConverter();
}

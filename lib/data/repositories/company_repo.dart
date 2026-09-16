import 'package:json_annotation/src/json_converter.dart';
import 'package:wall_box_2/data/database/tables/company_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';

class CompanyRepo extends Repository<CompanyData> {
  CompanyRepo({required super.onchanged});

  @override
  String get tableName => TableNames.company;

  @override
  CompanyDataJsonConverter get converter => CompanyDataJsonConverter();
  Future<CompanyData?> getById(String customerID) async =>
      await get('${CompanyColumns.customer_id} = ?', [customerID]);
}

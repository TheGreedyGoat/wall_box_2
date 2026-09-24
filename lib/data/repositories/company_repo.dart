import 'package:wall_box_2/data/database/tables/company_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';

/// The Reopsitory for all company data

class CompanyRepo extends Repository<CompanyData> {
  /// The Reopsitory for all company data

  CompanyRepo({required super.onchanged})
    : super(primaryKeyColumns: [CompanyColumns.customer_id]);

  @override
  String get tableName => TableNames.company;

  @override
  CompanyDataJsonConverter get converter => CompanyDataJsonConverter();

  /// Returns a customer's company data if they have any
  Future<CompanyData?> getById(String customerID) async =>
      await get('${CompanyColumns.customer_id} = ?', [customerID]);
}

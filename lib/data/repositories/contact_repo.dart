import 'package:wall_box_2/data/database/tables/contact_table.dart';
import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/database/repository.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';

/// Repository for contact data
class ContactRepo extends Repository<ContactData> {
  /// Repository for contact data
  ContactRepo({required super.onchanged})
    : super(primaryKeyColumns: [ContactColumns.customer_id]);

  @override
  String get tableName => TableNames.contact;

  @override
  ContactDataJsonConverter get converter => ContactDataJsonConverter();

  /// get the customer's contact data
  Future<ContactData?> getById(String customerID) async =>
      await get('${ContactColumns.customer_id} = ?', [customerID]);
}

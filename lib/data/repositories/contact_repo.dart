import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';

class ContactRepo extends Repository<ContactData> {
  @override
  String get tableName => TableNames.contact;

  @override
  ContactDataJsonConverter get converter => ContactDataJsonConverter();
}

import 'package:wall_box_2/data/database/tables/table_names.dart';
import 'package:wall_box_2/data/repositories/repository.dart';
import 'package:wall_box_2/logic/models/master_data/address.dart';

class AddressRepo extends Repository<Address> {
  @override
  String get tableName => TableNames.address;

  @override
  AddressJsonConverter get converter => AddressJsonConverter();
}

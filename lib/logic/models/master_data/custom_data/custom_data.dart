// ignore_for_file: public_member_api_docs
// TODO: include (JAAAA KOMMT NOCH)

import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

///Planned to be used for additional fieldsa the user cann add to customer data
///
class CustomDataField extends MasterData {
  final String customerID;
  final String label;
  final String value;

  CustomDataField({
    required this.customerID,
    required this.label,
    required this.value,
  });

  @override
  List<DataError?> get validationList => [];
}

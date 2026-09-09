import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';

part 'customer.freezed.dart';

@freezed
class Customer extends MasterData with _$Customer {
  final String id;
  final CompanyData? company;
  final PersonalData? personal;

  Customer({
    required this.id,
    this.company,
    this.personal,
  });

  @override
  List<DataError?> get validationList => [
    company == null && personal == null ? DataError.noCompanyOrPersonal : null,
    if (company != null) ...company!.validate(),
    if (personal != null) ...personal!.validate(),
  ];
}

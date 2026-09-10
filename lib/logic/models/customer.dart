import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal_data.dart';

part 'customer.freezed.dart';

/// Stores data for a customer.
///
/// A valid customer needs to have at least one of [company] & [personal] set
@freezed
class Customer extends MasterData with _$Customer {
  /// the id
  @override
  final String id;

  /// if the customer is a company
  @override
  final CompanyData? company;

  /// if the customer is a natural person
  ///
  /// Alternatively a contact person, boss etc. of the company
  @override
  final PersonalData? personal;

  /// Stores data for a customer.
  ///
  /// A valid customer needs to have at least one of [company] & [personal] set
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

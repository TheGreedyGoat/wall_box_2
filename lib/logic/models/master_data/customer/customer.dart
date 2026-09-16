import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/data/database/tables/customer_table.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/address/address.dart';
import 'package:wall_box_2/logic/models/master_data/company/company_data.dart';
import 'package:wall_box_2/logic/models/master_data/contact/contact_data.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';
import 'package:wall_box_2/logic/models/master_data/personal/personal_data.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

/// Stores data for a customer.
/// A valid customer needs to have at least one of [company] & [personal] set
///
@freezed
@JsonSerializable()
class Customer extends MasterData with _$Customer {
  /// the id
  @override
  final String id;

  String? taxID;

  /// Stores data for a customer.
  ///
  /// A valid customer needs to have at least one of [company] & [personal] set
  Customer({
    @JsonKey(name: CustomerColumns.id) required this.id,
    @JsonKey(name: CustomerColumns.taxID) this.taxID,
  });

  @override
  List<DataError?> get validationList => [];
}

///
class CustomerJsonConverter
    extends JsonConverter<Customer, Map<String, dynamic>> {
  ///
  const CustomerJsonConverter();

  @override
  Customer fromJson(Map<String, dynamic> json) => _$CustomerFromJson(json);

  @override
  Map<String, dynamic> toJson(Customer object) => _$CustomerToJson(object);
}

///
class CustomerJsonConverterNullable
    extends JsonConverter<Customer?, Map<String, dynamic>?> {
  ///
  const CustomerJsonConverterNullable();

  @override
  Customer? fromJson(Map<String, dynamic>? json) =>
      json == null ? null : _$CustomerFromJson(json);

  @override
  Map<String, dynamic>? toJson(Customer? object) =>
      object == null ? null : _$CustomerToJson(object);
}

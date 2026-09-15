part of '../interface_models/customer_data_package.dart';

class _CustomerRepo extends Repository<Customer> {
  @override
  String get tableName => TableNames.customer;

  @override
  CustomerJsonConverter get converter => CustomerJsonConverter();
}

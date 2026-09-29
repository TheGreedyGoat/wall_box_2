import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'phone.freezed.dart';
part 'phone.g.dart';

@freezed
@JsonSerializable()
/// represents a phone number
class Phone extends MasterData with _$Phone {
  ///
  final String data;

  @override
  String toString() => data;

  /// represents a phone number
  const Phone({required this.data});

  @override
  get validationList => [];
}

/// JSON Converter for Phone
class PhoneJsonConverter extends JsonConverter<Phone?, String?> {
  /// JSON Converter for Phone
  const PhoneJsonConverter();
  @override
  Phone? fromJson(String? json) => json is String ? Phone(data: json) : null;

  @override
  String? toJson(Phone? phone) => phone?.toString();
}

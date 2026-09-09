import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'phone.freezed.dart';
part 'phone.g.dart';

@freezed
@JsonSerializable()
class Phone extends MasterData with _$Phone {
  final String? nationalCode;
  final String? number;

  @override
  String toString() => '$nationalCode $number';

  Phone({
    this.nationalCode,
    this.number,
  });

  /// expects the number as a String. The national code has to be seperated by a whitespace
  static Phone? tryParse(String source) {
    final split = source.split(' ');
    if (split.length < 2) return null;

    final result = Phone(
      nationalCode: split[0],
      number: split.getRange(1, split.length).fold(
        '',
        (previousValue, element) {
          return '$previousValue $element';
        },
      ).trimLeft(),
    );
    return result;
  }

  @override
  get validationList => [
    (nationalCode ?? '').isEmpty ? DataError.noNationalCode : null,
    (number ?? '').isEmpty
        ? DataError.noPhoneNumber
        : int.tryParse(number!.replaceAll(' ', '')) == null
        ? DataError.invalidPhoneNumber
        : null,
  ];
}

class PhoneJsonConverter extends JsonConverter<Phone?, String?> {
  const PhoneJsonConverter();
  @override
  Phone? fromJson(String? json) => Phone.tryParse(json ?? '');

  @override
  String? toJson(Phone? phone) => phone?.toString();
}

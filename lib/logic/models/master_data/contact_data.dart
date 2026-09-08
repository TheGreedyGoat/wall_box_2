import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/models/master_data/email.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

class Contact extends MasterData {
  final Phone? phone;
  final Phone? mobile;
  final Email? email;

  Contact({
    required super.id,
    this.mobile,
    this.phone,
    this.email,
  });

  @override
  String? validate() {
    return super.processValidationList([
      phone == null && mobile == null ? 'Neother phone nor mobile set' : null,
      phone?.validate(),
      mobile?.validate(),
      email?.validate(),
    ]);
  }
}

@freezed
@JsonSerializable()
class Phone extends MasterData {
  final String? nationalCode;
  final String? number;

  @override
  String toString() => '$nationalCode $number';

  Phone({
    required super.id,
    this.nationalCode,
    this.number,
  });

  @override
  String? validate() => super.processValidationList([
    (nationalCode ?? '').isEmpty ? 'National Code missing' : null,
    (number ?? '').isEmpty
        ? 'Number is missing'
        : int.tryParse(number!.replaceAll(' ', '')) == null
        ? 'number contains not only numbers'
        : null,
  ]);
}

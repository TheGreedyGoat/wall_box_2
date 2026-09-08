import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/regexpressions.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';
import 'package:wall_box_2/logic/services/global.dart';

part 'email.freezed.dart';
part 'email.g.dart';

@freezed
@JsonSerializable(converters: [EmailConverter()])
class Email extends MasterData with _$Email {
  @override
  String id;
  final String? firstPart;
  final String? secondPart;
  final String? domain;

  Email({
    required this.id,
    this.firstPart,
    this.secondPart,
    this.domain,
  }) : super(id: id);

  static Email? tryParse(String source) {
    final match = Regexpressions.email.allMatches(source).firstOrNull;
    return match == null
        ? null
        : Email(
            id: generateId(),
            firstPart: match.group(1),
            secondPart: match.group(2),
            domain: match.group(3),
          );
  }

  @override
  String toString() => '$firstPart@$secondPart.$domain';

  @override
  String? validate() => super.processValidationList([
    tryParse(toString()) == null ? 'invalid email' : null,
  ]);
}

class EmailConverter extends JsonConverter<Email, String> {
  const EmailConverter();
  @override
  Email fromJson(String json) => Email.tryParse(json)!;

  @override
  String toJson(email) => email.toString();
}

class EmailConverterNullable extends JsonConverter<Email?, String?> {
  const EmailConverterNullable();
  @override
  Email? fromJson(String? json) => Email.tryParse(json ?? '');

  @override
  String? toJson(email) => email?.toString();
}

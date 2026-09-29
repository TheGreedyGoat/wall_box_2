import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/enums/data_error.dart';
import 'package:wall_box_2/logic/helpers/regexpressions.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

part 'email.freezed.dart';
part 'email.g.dart';

/// represents an email adress
///
/// [local]@[subdomain].[topLevelDomain]
@freezed
@JsonSerializable(converters: [EmailJsonConverter()])
class Email extends MasterData with _$Email {
  /// Regular expression to match an email address
  static final regexp = Regexpressions.email;
  @override
  /// the full email's text
  final String data;
  RegExpMatch? get _matchRegexp => regexp.firstMatch(data);

  /// extracts the local part (before the @) of the email
  String? get local => _matchRegexp?.group(1);

  /// Extracts the subdomain (eg 'gmail' or 'outlook' etc) from the email address
  String? get subdomain => _matchRegexp?.group(2);

  /// Extracts the top level domain (eg de, com etc) from the email address
  String? get topLevelDomain => _matchRegexp?.group(3);

  /// represents an email adress
  ///
  /// [local]@[subdomain].[topLevelDomain]
  const Email({required this.data});

  @override
  String toString() => data;

  @override
  List<DataError?> get validationList => [
    (local ?? '').isEmpty ||
            (subdomain ?? '').isEmpty ||
            (topLevelDomain ?? '').isEmpty
        ? DataError.invalidEmail
        : null,
  ];
}

/// JSON Converter for Email
class EmailJsonConverter extends JsonConverter<Email?, String?> {
  /// JSON Converter for Email
  const EmailJsonConverter();
  @override
  Email? fromJson(String? json) => Email(data: json ?? '');

  @override
  String? toJson(email) => email?.toString();
}

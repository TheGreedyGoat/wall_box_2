import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/data_error.dart';
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
  @override
  final String? local;
  @override
  final String? subdomain;
  @override
  final String? topLevelDomain;

  /// represents an email adress
  ///
  /// [local]@[subdomain].[topLevelDomain]
  Email({
    this.local,
    this.subdomain,
    this.topLevelDomain,
  });

  /// tries parsing an email address String. returns null if unsuccessful
  static Email? tryParse(String source) {
    final match = Regexpressions.email.allMatches(source).firstOrNull;
    try {
      return match == null
          ? null
          : Email(
              local: match.group(1),
              subdomain: match.group(2),
              topLevelDomain: match.group(3),
            );
    } catch (e) {
      return null;
    }
  }

  @override
  String toString() =>
      '${local ?? 'unknown'}@${subdomain ?? 'unknown'}.${topLevelDomain ?? 'unknown'}';

  @override
  List<DataError?> get validationList => [
    (local ?? '').isEmpty ? DataError.noEmailLocal : null,
    (subdomain ?? '').isEmpty ? DataError.noEmailSubdomain : null,
    (topLevelDomain ?? '').isEmpty ? DataError.noEmailTLD : null,
    (local ?? '').isNotEmpty && !local!.startsWith(RegExp(r'[a-z]|[A-Z]'))
        ? DataError.invalidEmailLocal
        : null,
  ];
}

/// JSON Converter for Email
class EmailJsonConverter extends JsonConverter<Email?, String?> {
  /// JSON Converter for Email
  const EmailJsonConverter();
  @override
  Email? fromJson(String? json) => Email.tryParse(json ?? '');

  @override
  String? toJson(email) => email?.toString();
}

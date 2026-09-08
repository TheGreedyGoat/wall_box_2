import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/logic/helpers/regexpressions.dart';
import 'package:wall_box_2/logic/models/master_data/master_data.dart';

/// contains data about a natural person
class PersonalData extends MasterData {
  final String? prename;
  final String? surname;
  final String? phone;
  final String? email;

  PersonalData({
    required super.id,
    this.prename,
    this.surname,
    this.phone,
    this.email,
  });

  String nonNull(String? Function(PersonalData data) getValue) =>
      getValue(this) ?? '';

  @override
  String? validate() {
    final List<String?> messages = List.empty(growable: true);
    messages.add(
      nonNull(
            (data) => data.prename,
          ).isEmpty
          ? 'prename missing'
          : null,
    );
    messages.add(
      nonNull(
            (data) => data.prename,
          ).isEmpty
          ? 'surname missing'
          : null,
    );
    // email
    messages.add(
      () {
            final mail = nonNull(
              (data) => data.email,
            );
            return mail.isEmpty ||
                Regexpressions.email
                        .allMatches(mail)
                        .firstOrNull
                        ?.group(0)
                        ?.trim() ==
                    mail.trim();
          }()
          ? null
          : 'email invalid.',
    );

    final errors = messages.where(
      (element) => element != null,
    );
    return errors.isEmpty
        ? null
        : errors.fold(
            '',
            (previousValue, element) => '$previousValue\n$element',
          );
  }
}

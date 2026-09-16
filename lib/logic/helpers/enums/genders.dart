import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/ui/language/language.dart';

@JsonEnum(valueField: 'code')
enum Gender {
  male,
  female,
  divers;

  String get titleDisplay => switch (this) {
    male => currentLanguage.mr,
    female => currentLanguage.mrs,
    divers => 'Divers',
  };

  int get code => values.indexOf(this);
}

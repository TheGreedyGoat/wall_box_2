import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:wall_box_2/ui/language/language.dart';

@JsonEnum(valueField: 'code')
/// depicts genders
enum Gender {
  ///what do you think this is?
  male,

  ///what do you think this is?
  female,

  ///what do you think this is?
  divers;

  /// returns the corresponding display string
  String get display => switch (this) {
    male => currentLanguage.mr,
    female => currentLanguage.mrs,
    divers => 'Divers',
  };
  // ignore: public_member_api_docs
  int get code => this.index;
}

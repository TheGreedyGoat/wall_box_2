import 'package:freezed_annotation/freezed_annotation.dart';

@JsonEnum(valueField: 'code')
enum Gender {
  male,
  female,
  divers;

  int get code => values.indexOf(this);
}

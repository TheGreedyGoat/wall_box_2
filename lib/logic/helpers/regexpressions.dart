/// A place to collect any kinds of RegExps wich may be used in multiple places
abstract class Regexpressions {
  ///
  static RegExp get email =>
      RegExp(r'([a-zA-Z][a-zA-Z0-9._%+-]*)@([a-zA-Z0-9-]+)\.([a-zA-Z]{2,})');
}

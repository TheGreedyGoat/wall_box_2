import 'package:uuid/uuid.dart';

/// quick access to generate a new uuid.
///
/// Yes, I am lazy.
String getNewId() => Uuid().v1();

// ignore_for_file: avoid_print

import 'package:wall_box_2/logic/helpers/date_timeextension.dart';

/// My attempt to get a unified logger system
///
/// Usage: In whatever method you wanna call a logger,
/// create an Instance passing the class the method is in and the methods name itself to
class Logger {
  final Type _objectType;
  final String _method;
  final bool _isActive;
  String get _prefix =>
      '[$_objectType.$_method] ${DateTime.now().toDynamicString(
        '~MM.~DD.~YY ~hh:~mm:~ss',
      )}';

  /// My attempt to get a unified logger system
  ///
  /// [objectType] and [method]
  ///
  Logger(
    Type objectType,
    String method, [
    bool isActive = true,
  ]) : _objectType = objectType,
       _method = method,
       _isActive = isActive;

  void _print(String text, int level) {
    final String message =
        '\x1B[3${switch (level) {
          2 => 1,
          1 => 3,
          _ => 7,
        }}m$text\x1B[0m';
    print(message);
  }

  /// logs the [message] to the console.
  ///
  /// [level] defines the type of message:
  ///
  /// - 0 => normal message (white)
  /// - 1 => warning (yellow)
  /// - 2 => error (red)
  ///
  /// setting [messageOnly] to false will add the current timestamp and the logs objectType + method to the start of the message
  void call(Object? message, [int level = 0, bool messageOnly = true]) {
    final logger = Logger(Logger, 'call');
    try {
      String logMessage = message.toString();
      assert(logMessage.isNotEmpty && level >= 0 && level <= 2);
      if (!_isActive && level < 2) return;

      if (!messageOnly) {
        logMessage = '$_prefix: $logMessage';
      }
      _print(logMessage, level);
    } catch (e) {
      logger.call(e.toString(), 2);
    }
  }
}

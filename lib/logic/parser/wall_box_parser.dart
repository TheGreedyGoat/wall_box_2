import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:wall_box_2/logic/models/wall_box_transaction.dart';
import 'package:wall_box_2/logic/parser/wall_box_log.dart';

///static class to validate and parse Wallbox files
class WallBoxParser {
  static bool isLoaded = false;

  static Future<List<WallBoxLog>> processFilePickerResult(
    List<PlatformFile>? result,
    Future<void> Function(String fileName) overrideOnExisting,
    Future<bool> Function(String content, String fileName) onLineError,
  ) async {
    if (result == null) return [];
    final logs = List<WallBoxLog>.empty(growable: true);
    for (int i = 0; i < result.length; i++) {
      final path = result[i].path;
      if (path == null) continue;
      final fullName = _fileNameFromPath(path);
      final splitName = fullName.split('.');
      final ext = splitName.removeLast();
      final name = splitName
          .fold(
            '',
            (previousValue, element) => '$previousValue.$element',
          )
          .replaceFirst('.', '');

      String content = await File(path).readAsString();
      final log = await _createLog(
        name,
        ext,
        content,
        overrideOnExisting,
        (content) => onLineError(content, fullName),
      );
      if (log != null) {
        logs.add(log);
      }
    }
    return logs;
  }

  static Future<WallBoxLog?> _createLog(
    String name,
    String ext,
    String content,
    Future<void> Function(String fileName) notifySkip,
    Future<bool> Function(String content) onLineError,
  ) async {
    // print('check if $name exists:');
    // print(LogFileData.checkExisting(name, ext));

    final log = await WallBoxLog.fromSource(content, onLineError);
    if (log == null) return null;
    try {
      //TODO save logFile
      log.createTransactions();

      return log;
    } catch (e) {
      print(e);
      await notifySkip(log.fileName);
      return null;
    }
  }

  static String _fileNameFromPath(String path) => path.split('\\').last;
}

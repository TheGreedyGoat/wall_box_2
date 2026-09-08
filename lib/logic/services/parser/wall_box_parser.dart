import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:wall_box_2/logic/models/logs/wall_box_log.dart';
import 'package:wall_box_2/logic/services/singleton.dart';

///static class to validate and parse Wallbox files
class WallBoxParser implements Singleton<WallBoxParser> {
  /// returns the singleton instance
  static WallBoxParser get instance =>
      Singleton.getInstanceOfType(WallBoxParser) as WallBoxParser;

  /// takes a list of [PlatformFile]s (=> logg files) and parses them one by one
  ///
  /// Returns the parsed [WallBoxLog]s
  Future<List<WallBoxLog>> processFilePickerResult(
    List<PlatformFile>? result,
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
        (content) => onLineError(content, fullName),
      );
      if (log != null) {
        logs.add(log);
      }
    }
    return logs;
  }

  Future<WallBoxLog?> _createLog(
    String name,
    String ext,
    String content,
    Future<bool> Function(String content) onLineError,
  ) async => await WallBoxLog.fromSource(content, onLineError);

  static String _fileNameFromPath(String path) => path.split('\\').last;
}

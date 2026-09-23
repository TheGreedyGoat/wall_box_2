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
    List<PlatformFile>? result, {
    required Future<bool> Function(String content, String fileName) onLineError,
    required void Function(String fileName) onLogAlreadyExists,
  }) async {
    if (result == null) return [];
    final logs = List<WallBoxLog>.empty(growable: true);
    for (int i = 0; i < result.length; i++) {
      final path = result[i].path;
      if (path == null) continue;
      final fullName = _fileNameFromPath(path);
      String content = await File(path).readAsString();
      final log = await WallBoxLog.fromSource(
        content,
        onLineError: (p0) async {
          return await onLineError(p0, fullName);
        },
        onLogAlreadyExists: () => onLogAlreadyExists(fullName),
      );
      if (log != null) {
        logs.add(log);
      }
    }
    return logs;
  }

  static String _fileNameFromPath(String path) => path.split('\\').last;
}

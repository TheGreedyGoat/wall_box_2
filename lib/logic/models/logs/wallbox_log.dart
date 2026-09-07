import 'package:wall_box_2/logic/models/logs/log_file.dart';

/// contains the complete log of one Wallbox
class WallboxLog {
  /// The Wallboxe's Device ID
  final String wallboxID;

  /// all the generated LogFiles
  final List<LogFile> logFiles;

  WallboxLog._({required this.wallboxID, required this.logFiles});

  /// contains the complete log of one Wallbox
  ///
  /// [logFiles] gets sorted by generationDate automatically
  factory WallboxLog({
    required String wallboxID,
    required List<LogFile> logFiles,
  }) {
    logFiles.sort(
      (a, b) {
        return a.generationDate.compareTo(b.generationDate);
      },
    );
    return WallboxLog._(wallboxID: wallboxID, logFiles: logFiles);
  }
}

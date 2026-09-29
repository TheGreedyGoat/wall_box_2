import 'dart:io';
import 'dart:math';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;
import 'package:wall_box_2/logic/helpers/date_timeextension.dart';

class WallboxLogGenerator {
  static const List<String> ids = [
    'ALEX000000',
    'ANDREAS000',
    'YACUP9999',
  ];

  static String _filename(DateTime date, int index, String deviceID) {
    return '${date.year}${date.month < 10 ? '0' : ''}${date.month}${date.day < 10 ? '0' : ''}${date.day} ${deviceID}_$index.csv';
  }

  static Future<List<File>> generateFiles({
    required String deviceID,
    required DateTime startDate,
    required double initialPowerLevel,
    required Duration maxDuration,
    required int numFiles,
  }) async {
    List<List<String>> results = List.empty(growable: true);
    List<String> content = _generateFileContent(
      startDate,
      initialPowerLevel,
      maxDuration,
    ).split('\n');
    DateTime generationDate = startDate;
    print(content.length);

    int firstLine = 0;
    for (int i = 0; i < numFiles - 1; i++) {
      int lastLine = firstLine + (content.length / numFiles).floor();

      results.add(
        _extractSubFile(content, firstLine, lastLine, generationDate, deviceID),
      );
      generationDate = generationDate.add(Duration(days: 1));
      firstLine = lastLine;
    }
    final dir = await getGenerationDirectory();
    if (!(await dir.exists())) return [];
    List<File> files = List.empty(growable: true);

    for (final contents in results) {
      File file = File(
        path.join(
          dir.path,
          _filename(startDate, results.indexOf(contents), deviceID),
        ),
      );
      String fileContent = contents.fold(
        '',
        (previousValue, line) => '$previousValue$line\n',
      );
      await file.writeAsString(fileContent);
      files.add(file);
    }
    return files;
  }

  static List<String> _extractSubFile(
    List<String> source,
    int from,
    int to,
    DateTime generationDate,
    String deviceID,
  ) {
    return [
      '# Device, $deviceID',
      '# Generated, ${generationDate.toDynamicString('DD.MM.YYYY hh:mm:ss')}',
      ...source.getRange(from, to),
    ];
  }

  static String _generateFileContent(
    DateTime startDate,
    double initialPowerLevel,
    Duration maxDuration,
  ) {
    String content = '';
    DateTime endDate = startDate.add(maxDuration);

    DateTime startOfCharging = startDate;
    double currentPowerLevel = initialPowerLevel;
    while (startOfCharging.compareTo(endDate) < 0) {
      final (blockContent, level, stopTime) = generateChargingBlock(
        ids[Random().nextInt(ids.length)],
        currentPowerLevel,
        startOfCharging,
      );

      content += blockContent;
      currentPowerLevel = level;
      startOfCharging = stopTime;
    }
    return content;
  }

  static (String, double, DateTime) generateChargingBlock(
    String id,
    double powerLevel,
    DateTime startTime,
  ) {
    const int maxChargingHours = 5;
    DateTime stopTime = startTime.add(
      Duration(hours: 1 + Random().nextInt(maxChargingHours)),
    );

    String result = startLine(startTime, powerLevel, id);
    result += mvLine(startTime, powerLevel);
    while (startTime.compareTo(stopTime) < 0) {
      powerLevel += 3;
      startTime = startTime.add(Duration(minutes: 15));
      result += mvLine(startTime, powerLevel);
    }
    result += mvLine(stopTime, powerLevel);
    result += stopLine(stopTime, powerLevel, id);
    return (result, powerLevel, stopTime);
  }

  static String startLine(DateTime date, double powerLevel, String id) {
    return 'txstart2: id 0xffffffffffffffff, socket 1, ${date.toString()} ${powerLevel}kWh $id 3 2 N\n';
  }

  static String mvLine(DateTime date, double powerLevel) {
    return 'mv: socket 1, ${date.toString()} $powerLevel N\n';
  }

  static String stopLine(DateTime date, double powerLevel, String id) {
    return 'txstop2: id 0xffffffffffffffff, socket 1, ${date.toString()} ${powerLevel}kWh $id 3 2 N\n';
  }
}

Future<Directory> getGenerationDirectory() async {
  final projectDir = Directory.current.path;

  final Directory genDir = Directory(
    path.join(projectDir, 'test', 'generated_files'),
  );

  if (!await genDir.exists()) {
    await genDir.create();
  }
  return genDir;
}

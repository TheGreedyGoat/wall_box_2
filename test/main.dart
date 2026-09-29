import 'wallbox_log_generator.dart';

void main() async {
  await WallboxLogGenerator.generateFiles(
    deviceID: 'ACE52486669',
    startDate: DateTime(2025),
    initialPowerLevel: 1234.567,
    maxDuration: Duration(days: 50),
    numFiles: 3,
  );
}

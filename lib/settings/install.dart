import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:milibase/settings/update_func.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadAndInstallUpdate() async {
  final tempDir = await getTemporaryDirectory();
  final installerPath = '${tempDir.path}\\update_installer.exe';

  String? versionTag = await getLatestGitHubVersion();
  // 1. Download the installer
  final response = await http.get(
    Uri.parse(
      'https://github.com/stenakis/Milibase/releases/download/$versionTag/Milibase.Setup.exe',
    ),
  );
  final file = File(installerPath);
  await file.writeAsBytes(response.bodyBytes);

  // 2. Run the installer silently and exit the app
  await Process.start(installerPath, [
    '/VERYSILENT',
  ], mode: ProcessStartMode.detached);

  // 3. Exit current app so installer can replace files
  exit(0);
}

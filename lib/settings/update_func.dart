import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:milibase/variables.dart';

Future<bool> checkVersion() async {
  const currentVersion = appVersion;

  final remoteVersion = await getLatestGitHubVersion();
  if (remoteVersion == null) return false;

  final bool outdated = _isVersionLower(
    currentVersion.toString(),
    remoteVersion,
  );

  if (outdated) return true;
  return false;
}

Future<String?> getLatestGitHubVersion() async {
  const url = 'https://api.github.com/repos/stenakis/Milibase/releases/latest';

  final response = await http.get(
    Uri.parse(url),
    headers: {'Accept': 'application/vnd.github.v3+json'},
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    final tag = json['tag_name'] as String; // e.g. "v0.7"
    return tag.replaceAll('v', ''); // strip the "v" → "0.7"
  }

  return null;
}

bool _isVersionLower(String current, String remote) {
  final currentParts = current.split('.').map(int.parse).toList();
  final remoteParts = remote.split('.').map(int.parse).toList();

  // Pad shorter list with zeros (e.g. "1.0" vs "1.0.1")
  final length = [
    currentParts.length,
    remoteParts.length,
  ].reduce((a, b) => a > b ? a : b);
  while (currentParts.length < length) {
    currentParts.add(0);
  }
  while (remoteParts.length < length) {
    remoteParts.add(0);
  }

  for (int i = 0; i < length; i++) {
    if (currentParts[i] < remoteParts[i]) return true;
    if (currentParts[i] > remoteParts[i]) return false;
  }

  return false; // They're equal
}

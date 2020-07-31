import 'package:http/http.dart' as http;
import 'package:tem_app/config/constants.dart';
import 'dart:convert';

Future<Map> getPath(String path) async {
  final response = await http.get(path, headers: await authHeaders());

  print("http(${response.statusCode}): $path");

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    return responseBody;
  } else {
    final prefs = await appPrefs();
    prefs.setString(
        lastApiResponseMessage, "${response.statusCode}: ${response.body}");
    print(prefs.getString(lastApiResponseMessage));
    return Map();
  }
}

// async api methods go here
Future<Map> getWorklogs() async {
  return getPath(
      '$baseUri/$apiPrefix/worklog/?expand=equipment_charges,manhours_charges,created_by');
}

Future<Map> getClients() async {
  return getPath('$baseUri/$apiPrefix/client');
}

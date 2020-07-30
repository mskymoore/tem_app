import 'package:http/http.dart' as http;
import 'package:tem_app/config/constants.dart';
import 'dart:convert';

// async api methods go here
Future getWorklogs() async {
  final logoutUri =
      '${baseUri}/${apiPrefix}/worklog/?expand=equipment_charges,manhours_charges';
  final response = await http.get(logoutUri, headers: await authHeaders());

  print("worklogs response code ${response.statusCode}");

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

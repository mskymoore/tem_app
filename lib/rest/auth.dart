import 'package:http/http.dart' as http;
import 'package:tem_app/config/constants.dart';
import 'dart:convert';

Future<bool> tokenLogin(formData) async {
  final loginUri = '${baseUri}/${authPrefix}/token/login';
  http.Response response = await http.post(
    loginUri,
    body: formData,
  );
  final prefs = await appPrefs();

  print("login response code ${response.statusCode}");

  if (response.statusCode == 200) {
    prefs.setString(authToken, jsonDecode(response.body)[authToken]);
    prefs.setBool(isLoggedIn, true);
    return true;
  } else {
    prefs.setBool(isLoggedIn, false);
    prefs.setString(lastApiResponseMessage,
            jsonDecode(response.body)['non_field_errors'][0]) ??
        "";
  }

  return false;
}

Future<http.Response> tokenLogout() async {
  final logoutUri = '${baseUri}/${authPrefix}/token/logout';
  final response = await http.post(logoutUri, headers: await authHeaders());
  final prefs = await appPrefs();

  print("logout response code ${response.statusCode}");

  if (response.statusCode == 204) {
    prefs.setBool(isLoggedIn, false);
  } else {
    prefs.setString(
        lastApiResponseMessage, "${response.statusCode}: ${response.body}");
  }
}

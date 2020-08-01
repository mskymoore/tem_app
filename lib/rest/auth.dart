import 'package:http/http.dart' as http;
import 'package:tem_app/config/constants.dart';
import 'dart:convert';
import 'package:tem_app/models/models.dart';

Future<bool> tokenLogin(formData) async {
  final loginUri = '$baseUri/$authPrefix/token/login';
  http.Response response = await http.post(
    loginUri,
    body: formData,
  );
  final prefs = await appPrefs();

  print("http(${response.statusCode}): $loginUri");

  if (response.statusCode == 200) {
    prefs.setString(authToken, jsonDecode(response.body)[authToken]);
    return true;
  } else {
    prefs.setString(lastApiResponseMessage,
        jsonDecode(response.body)['non_field_errors'][0]);
    return false;
  }
}

void tokenLogout() async {
  final logoutUri = '$baseUri/$authPrefix/token/logout';
  final response = await http.post(logoutUri, headers: await authHeaders());

  print("http(${response.statusCode}): $logoutUri");

  if (response.statusCode != 204) {
    final prefs = await appPrefs();
    prefs.setString(
        lastApiResponseMessage, "${response.statusCode}: ${response.body}");
  }
}

Future<User> usersMe() async {
  final meUri = '$baseUri/$authPrefix/users/me';
  final response = await http.get(meUri, headers: await authHeaders());
  final prefs = await appPrefs();

  print("http(${response.statusCode}): $meUri");

  if (response.statusCode == 200) {
    final user = jsonDecode(response.body);

    return User("${user['id']}", user['username'],
        "${user['first_name']} ${user['last_name']}");
  } else {
    prefs.setString(
        lastApiResponseMessage, "${response.statusCode}: ${response.body}");
    return null;
  }
}

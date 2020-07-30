import 'package:http/http.dart' as http;
import 'package:tem_app/constants.dart';
import 'dart:convert';

Future<http.Response> login(formData) async {
  var map = new Map<String, dynamic>();
  map[email] = formData.formEmail;
  map[password] = formData.formPassword;
  http.Response response = await http.post(
    loginUri,
    body: map,
  );

  if (response.statusCode == 200) {
    final prefs = await appPrefs();
    print("login response code ${response.statusCode}");
    prefs.setString(authToken, jsonDecode(response.body)[authToken]);
  }

  return response;
}

Future<http.Response> logout() async {
  final response = await http.post(logoutUri, headers: await authHeaders());
  print("logout response code ${response.statusCode}");
}

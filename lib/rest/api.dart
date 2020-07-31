import 'package:http/http.dart' as http;
import 'package:tem_app/config/constants.dart';
import 'dart:convert';

void setLastMessage(code, path, body) async {
  final prefs = await appPrefs();
  prefs.setString(
      lastApiResponseMessage, "http($code): $path: ${body['detail']}");
  print(prefs.getString(lastApiResponseMessage));
}

Future<Map> getPath(String path) async {
  final requestPath = "$baseUri/$apiPrefix/$path";
  final response = await http.get(requestPath, headers: await authHeaders());

  final responseBody = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print("http(${response.statusCode}): $requestPath");
    return responseBody;
  } else {
    setLastMessage(response.statusCode, requestPath, responseBody);
    return null;
  }
}

Future<Map> postPath(String path, Map data) async {
  final requestPath = "$baseUri/$apiPrefix/$path";
  final response =
      await http.post(requestPath, headers: await authHeaders(), body: data);

  final responseBody = jsonDecode(response.body);

  if (response.statusCode == 201) {
    print("http(${response.statusCode}): $requestPath");
    return responseBody;
  } else {
    setLastMessage(response.statusCode, requestPath, responseBody);
    return null;
  }
}

// async api methods go here
Future<Map> getWorklogs() async {
  return getPath(
      'worklog/?expand=equipment_charges,manhours_charges,created_by');
}

Future<Map> getClients() async {
  return getPath('client');
}

Future<Map> getRates() async {
  return getPath('rate');
}

Future<Map> getSites() async {
  return getPath('site');
}

Future<Map> getEquipments() async {
  return getPath('equipment');
}

Future<Map> getDayRates() async {
  return getPath('dayrate');
}

Future<Map> getRegions() async {
  return getPath('region');
}

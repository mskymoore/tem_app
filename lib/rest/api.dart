import 'package:http/http.dart' as http;
import 'package:tem_app/config/constants.dart';
import 'dart:convert';

void setLastMessage(code, path, body, key) async {
  final prefs = await appPrefs();
  if (key != null) {
    prefs.setString(lastApiResponseMessage, "http($code): $path: ${body[key]}");
  } else {
    prefs.setString(lastApiResponseMessage, "http($code): $path: $body");
  }
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
    setLastMessage(response.statusCode, requestPath, responseBody, 'detail');
    return null;
  }
}

Future<Map> postPath(String path, Map data) async {
  final requestPath = "$baseUri/$apiPrefix/$path";
  final requestData = jsonEncode(data);
  print(requestData);
  Map requestHeaders = await authHeaders();
  requestHeaders['Content-Type'] = 'application/json';
  print(requestHeaders.toString());
  final response =
      await http.post(requestPath, headers: requestHeaders, body: requestData);
  final responseBody = jsonDecode(response.body);

  if (response.statusCode == 201) {
    print("http(${response.statusCode}): $requestPath");
    print(responseBody);
    return responseBody;
  } else {
    setLastMessage(response.statusCode, requestPath, responseBody, null);
    return null;
  }
}

Future<Map> postWorklog(data) async {
  return postPath('$worklog/', data);
}

Future<Map> postManHoursCharge(data) async {
  return postPath('$manhrscharge/', data);
}

Future<Map> postEquipmentCharge(data) async {
  return postPath('$equipcharge/', data);
}

Future<Map> getWorklogs() async {
  return getPath(
      'worklog/?expand=equipment_charges,manhours_charges,created_by');
}

Future<Map> getClients() async {
  return getPath(client);
}

Future<Map> getRates() async {
  return getPath(rate);
}

Future<Map> getSites() async {
  return getPath(site);
}

Future<Map> getEquipments() async {
  return getPath(equipment);
}

Future<Map> getDayRates() async {
  return getPath(dayrate);
}

Future<Map> getRegions() async {
  return getPath(region);
}

Future<Map> getManHours() async {
  return getPath(manhrscharge);
}

Future<Map> getEmployees() async {
  return getPath(employee);
}

Future<Map> getPositions() async {
  return getPath(position);
}

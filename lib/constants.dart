import 'package:shared_preferences/shared_preferences.dart';

Future appPrefs() async {
  return await SharedPreferences.getInstance();
}

//preferences keys
final authToken = 'auth_token';

//configuration
final baseUri = 'https://api.rwx.dev';
final loginUri = '${baseUri}/auth/token/login';
final logoutUri = '${baseUri}/auth/token/logout';

//string constants
final email = 'email';
final password = 'password';

//regular expressions
RegExp emailRegExp = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

//headers
Future authHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  final aToken = prefs.getString(authToken);
  return {'Authorization': 'Token $aToken'};
}

import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> appPrefs() async {
  return await SharedPreferences.getInstance();
}

//preferences keys
final authToken = 'auth_token';
final isLoggedIn = 'isLoggedIn';
final lastApiResponseMessage = 'lastMessage';
final username = 'username';
final name = 'name';

//configuration
final baseUri = 'https://api.rwx.dev';
final authPrefix = 'auth';
final apiPrefix = 'api';

//string constants
final email = 'email';
final password = 'password';
final firstName = 'first_name';
final lastName = 'last_name';

//regular expressions
RegExp emailRegExp = new RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

//headers
Future<dynamic> authHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  final aToken = prefs.getString(authToken) ?? '';
  return {'Authorization': 'Token $aToken'};
}

//import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(TemApp());
}

final auth_token = 'auth_token';
final baseUri = 'https://api.rwx.dev/';

Future authHeaders() async {
  final prefs = await SharedPreferences.getInstance();
  final aToken = prefs.getString(auth_token);
  return {'Authorization': 'Token $aToken'};
}

class FormData {
  String email;
  String password;
  FormData({
    this.email,
    this.password,
  });

  // unused but leaving as an example for now
  static String toJson(FormData data) {
    Map<String, dynamic> map() => {
          'email': data.email,
          'password': data.password,
        };

    String jsonPayload = jsonEncode(map());
    return jsonPayload;
  }
}

class TemApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tem App Beta',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(title: 'TEM APP BETA'),
    );
  }
}

class TemLoginForm extends StatefulWidget {
  @override
  TemLoginFormState createState() {
    return TemLoginFormState();
  }
}

class TemLoginFormState extends State<TemLoginForm> {
  final _formKey = GlobalKey<FormState>();
  RegExp emailRegExp = new RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  FormData formData = FormData();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'What\'s your email address?',
              labelText: 'Email Address',
            ),
            validator: (value) {
              if (!emailRegExp.hasMatch(value)) {
                return 'Invalid email address';
              }
              setState(() {
                formData.email = value;
              });
              return null;
            },
          ),
          TextFormField(
            obscureText: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.lock),
              hintText: 'What\'s your password?',
              labelText: 'Password',
            ),
            validator: (value) {
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }
              setState(() {
                formData.password = value;
              });
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                var map = new Map<String, dynamic>();
                map['email'] = formData.email;
                map['password'] = formData.password;
                final uri = '${baseUri}auth/token/login';
                http.Response response = await http.post(
                  uri,
                  body: map,
                );

                if (response.statusCode == 200) {
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString(
                      auth_token, jsonDecode(response.body)[auth_token]);

                  _showDialog(
                      "Successful Login: ${prefs.getString(auth_token)}");
                } else {
                  _showDialog("Failed Login: ${response.statusCode}");
                }

                print(response.statusCode);
                print(response.body);
              }
            },
            child: Text('Submit'),
          )
        ]));
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      child: AlertDialog(
        title: Text(message),
        actions: [
          FlatButton(
            child: Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Logout',
            onPressed: () async {
              final uri = '${baseUri}auth/token/logout';
              final auth = await authHeaders();
              http.Response response = await http.post(uri, headers: auth);
              print(response.statusCode);
              print(response.body);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TemLoginForm(),
          ],
        ),
      ),
    );
  }
}

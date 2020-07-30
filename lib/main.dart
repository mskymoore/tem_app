import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(TemApp());
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
        primarySwatch: Colors.blue,
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
  String auth_token;

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

                final uri = 'https://api.rwx.dev/auth/token/login';
                http.Response response = await http.post(
                  uri,
                  body: map,
                );

                if (response.statusCode == 200) {
                  auth_token = jsonDecode(response.body)['auth_token'];

                  _showDialog("Successful Login: ${auth_token}");
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

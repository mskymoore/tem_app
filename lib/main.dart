//import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tem_app/auth.dart';
import 'package:tem_app/constants.dart';

void main() {
  runApp(TemApp());
}

void _showDialog(String message, BuildContext context) {
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

class FormData {
  String formEmail;
  String formPassword;
  FormData({
    this.formEmail,
    this.formPassword,
  });

  // unused but leaving as an example for now
  static String toJson(FormData data) {
    Map<String, dynamic> map() => {
          email: data.formEmail,
          password: data.formPassword,
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
                formData.formEmail = value;
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
                formData.formPassword = value;
              });
              return null;
            },
          ),
          RaisedButton(
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                FutureBuilder(
                  future: login(formData),
                  builder: (context, snapshot) {
                    print(snapshot.toString());
                  },
                );
              }
            },
            child: Text('Submit'),
          )
        ]));
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
              FutureBuilder(
                  future: logout(),
                  builder: (context, snapshot) {
                    print(snapshot.toString());
                  });
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

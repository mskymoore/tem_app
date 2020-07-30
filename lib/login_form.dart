import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tem_app/auth.dart';
import 'package:tem_app/constants.dart';
import 'package:tem_app/logged_in_view.dart';

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
                bool loginSuccess = await tokenLogin(formData);
                final prefs = await appPrefs();
                if (loginSuccess) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(title: 'TEM APP BETA')),
                  );
                } else {
                  showDialog(
                    context: context,
                    child: AlertDialog(
                      title:
                          Text(prefs.getString(lastApiResponseMessage) ?? ""),
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
            },
            child: Text('Login'),
          )
        ]));
  }
}

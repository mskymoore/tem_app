import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';

class CreateWorklogForm extends StatefulWidget {
  @override
  CreateWorklogFormState createState() {
    return CreateWorklogFormState();
  }
}

class CreateWorklogFormState extends State<CreateWorklogForm> {
  final _formKey = GlobalKey<FormState>();
  Map formData = {email: '', password: ''};

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'Summarize your worklog...',
                  labelText: 'Summary',
                ),
                validator: (value) {
                  if (value == '') {
                    return 'Please enter a summary.';
                  }
                  setState(() {
                    formData[email] = value;
                  });
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: 'What\'s your password?',
                    labelText: 'Password'),
                validator: (value) {
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  setState(() {
                    formData[password] = value;
                  });
                  return null;
                },
              ),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        final prefs = await appPrefs();
                        //bool loginSuccess = await tokenLogin(formData);
                        bool loginSuccess = true;
                        if (loginSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage(
                                        'TEM APP BETA',
                                      )));
                        } else {
                          showDialog(
                            context: context,
                            child: AlertDialog(
                              title: Text(
                                  prefs.getString(lastApiResponseMessage) ??
                                      ""),
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
                  ))
            ])));
  }
}

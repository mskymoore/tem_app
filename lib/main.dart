import 'package:flutter/material.dart';
import 'package:tem_app/views/login_view.dart';

void main() {
  runApp(TemApp());
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

import 'package:flutter/material.dart';
import 'package:tem_app/views/login.dart';
import 'package:tem_app/views/logged_in.dart';
import 'package:tem_app/views/client.dart';
import 'package:tem_app/views/initial.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => IsLoginRequired());
      case '/login':
        return MaterialPageRoute(
            builder: (_) => LoginPage(title: "TEM LOG IN"));
      case '/worklog':
        return MaterialPageRoute(builder: (_) => MainPage("TEM APP BETA"));
      case '/client':
        return MaterialPageRoute(builder: (_) => ClientPage("TEM APP BETA"));
      default:
        return MaterialPageRoute(
            builder: (_) => LoginPage(title: "TEM LOG IN"));
    }
  }
}

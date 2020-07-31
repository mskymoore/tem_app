import 'package:flutter/material.dart';
import 'package:tem_app/views/login.dart';
import 'package:tem_app/views/logged_in.dart';
import 'package:tem_app/views/client.dart';
import 'package:tem_app/views/initial.dart';
import 'package:tem_app/views/worklog.dart';

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
      case '/create_worklog':
        return MaterialPageRoute(builder: (_) => WorklogPage("Create Worklog"));
      case '/client':
        return MaterialPageRoute(builder: (_) => ClientPage("TEM APP BETA"));
      default:
        return MaterialPageRoute(
            builder: (_) => LoginPage(title: "TEM LOG IN"));
    }
  }
}

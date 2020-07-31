import 'package:flutter/material.dart';
import 'package:tem_app/views/login.dart';
import 'package:tem_app/views/logged_in.dart';
import 'package:tem_app/views/client.dart';
import 'package:tem_app/views/initial.dart';
import 'package:tem_app/views/worklog.dart';

class RouteGenerator {
  static const String root = '/';
  static const String login = '/login';
  static const String worklog = '/worklog';
  static const String create_worklog = '/create_worklog';
  static const String client = '/client';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case root:
        return MaterialPageRoute(
          builder: (_) => IsLoginRequired(),
          settings: RouteSettings(name: root),
        );
      case login:
        return MaterialPageRoute(
          builder: (_) => LoginPage(title: "TEM LOG IN"),
          settings: RouteSettings(name: login),
        );
      case worklog:
        return MaterialPageRoute(
          builder: (_) => MainPage("TEM APP BETA"),
          settings: RouteSettings(name: worklog),
        );
      case create_worklog:
        return MaterialPageRoute(
          builder: (_) => WorklogPage("Create Worklog"),
          settings: RouteSettings(name: create_worklog),
        );
      case client:
        return MaterialPageRoute(
          builder: (_) => ClientPage("TEM APP BETA"),
          settings: RouteSettings(name: client),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(title: "TEM LOG IN"),
          settings: RouteSettings(name: login),
        );
    }
  }
}

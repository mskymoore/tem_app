import 'package:flutter/material.dart';
import 'package:tem_app/views/login.dart';
import 'package:tem_app/views/logged_in.dart';
import 'package:tem_app/views/client.dart';
import 'package:tem_app/views/initial.dart';
import 'package:tem_app/views/worklog.dart';
import 'package:tem_app/views/manhourscharge.dart';
import 'package:tem_app/views/equipmentcharge.dart';

class RouteGenerator {
  static const String commonTitle = "TEM APP ALPHA";
  static const String root = '/';
  static const String login = '/login';
  static const String worklog = '/worklog';
  static const String create_worklog = '/create_worklog';
  static const String client = '/client';
  static const String create_manhrscharge = '/create_manhrscharge';
  static const String create_equipmentcharge = '/create_equipcharge';

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
          builder: (_) => LoginPage(),
          settings: RouteSettings(name: login),
        );
      case worklog:
        return MaterialPageRoute(
          builder: (_) => MainPage(),
          settings: RouteSettings(name: worklog),
        );
      case create_manhrscharge:
        final Map args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ManHrsPage(args['title'], args['callback']),
          settings: RouteSettings(name: create_manhrscharge),
        );
      case create_equipmentcharge:
        final Map args = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => EquipmentPage(args['title'], args['callback']),
            settings: RouteSettings(name: create_manhrscharge));
      case create_worklog:
        return MaterialPageRoute(
          builder: (_) => WorklogPage("Create Worklog"),
          settings: RouteSettings(name: create_worklog),
        );
      case client:
        return MaterialPageRoute(
          builder: (_) => ClientPage(commonTitle),
          settings: RouteSettings(name: client),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => LoginPage(),
          settings: RouteSettings(name: login),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'package:tem_app/widgets/worklog.dart';
import 'package:tem_app/widgets/scaffold.dart';

class MainPage extends StatelessWidget {
  static const String title = 'Worklogs';
  static const String worklog = '/worklog';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => MainPage(), settings: RouteSettings(name: worklog));
  }

  @override
  Widget build(BuildContext context) {
    return TemScaffold(
      "TEM APP BETA",
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            WorklogFutureBuilder(),
          ],
        ),
      ),
    );
  }
}

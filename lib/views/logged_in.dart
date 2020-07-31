import 'package:flutter/material.dart';
import 'package:tem_app/widgets/worklog.dart';
import 'package:tem_app/widgets/scaffold.dart';

class MainPage extends StatefulWidget {
  final String title;
  Map worklogs;
  MainPage(this.title);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

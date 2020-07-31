import 'package:flutter/material.dart';
import 'package:tem_app/widgets/worklog_form.dart';
import 'package:tem_app/widgets/scaffold.dart';

class WorklogPage extends StatefulWidget {
  final String title;
  WorklogPage(this.title);

  @override
  _WorklogPageState createState() => _WorklogPageState();
}

class _WorklogPageState extends State<WorklogPage> {
  @override
  Widget build(BuildContext context) {
    return TemScaffold(
      widget.title,
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CreateWorklogForm(),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tem_app/widgets/worklog_form.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';

class WorklogPage extends StatefulWidget {
  final String title;
  WorklogPage(this.title);

  @override
  _WorklogPageState createState() => _WorklogPageState();
}

class _WorklogPageState extends State<WorklogPage> {
  Map formData;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      drawer: Drawer(child: DrawerFutureBuilder()),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: CreateWorklogForm((value) => {
            setState(() {
              this.formData = value;
            })
          }),
      floatingActionButton: FabCircularMenu(children: <Widget>[
        IconButton(
            icon: Icon(Icons.assignment_ind),
            onPressed: () {
              print('add manhours charge');
            }),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              print('add equipment charge');
            }),
        IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              final prefs = await appPrefs();
              final user = prefs.getString(id);
              this.formData['created_by'] = user;
              postWorklog(this.formData);
            })
      ]),
    ));
  }
}

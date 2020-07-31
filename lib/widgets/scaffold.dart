import 'package:flutter/material.dart';
import 'package:tem_app/widgets/drawer.dart';

class TemScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  const TemScaffold(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            drawer: Drawer(child: DrawerFutureBuilder()),
            appBar: AppBar(
              title: Text(this.title),
              actions: <Widget>[],
            ),
            body: this.body,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/create_worklog');
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            )));
  }
}

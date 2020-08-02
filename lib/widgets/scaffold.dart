import 'package:flutter/material.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';

void plusButtonBehavior(context) {
  final currentRoute = ModalRoute.of(context).settings.name;
  if (currentRoute == '/worklog' || currentRoute == '/') {
    Navigator.of(context).pushNamed('/create_worklog');
  } else if (currentRoute == '/create_worklog') {
    print(currentRoute);
    return;
  } else {
    print(currentRoute);
    return;
  }
}

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Route plusButtonRoute;
  const AppScaffold(this.title, this.body, this.plusButtonRoute);

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
                context
                    .bloc<WorklogBloc>()
                    .add(const CreateWorklogButtonTapped());
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            )));
  }
}

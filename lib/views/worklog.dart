import 'package:flutter/material.dart';
import 'package:tem_app/widgets/worklog_form.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorklogPage extends StatelessWidget {
  final String title;
  WorklogPage(this.title);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WorklogPage('Worklogs'));
  }

  Map formData = {
    summary: '',
    client: '',
    'created_by': '',
    'approved': 'false',
    'disputed': 'false',
    'manhours_charges': [],
    'equipment_charges': [],
    'included_employees': []
  };

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      drawer: Drawer(child: DrawerFutureBuilder()),
      appBar: AppBar(
        title: Text(this.title),
        actions: <Widget>[],
      ),
      body: CreateWorklogForm(_formKey),
      floatingActionButton: FabCircularMenu(children: <Widget>[
        IconButton(
            icon: Icon(Icons.assignment_ind),
            onPressed: () {
              context
                  .bloc<WorklogBloc>()
                  .add(const CreateEquipChargeButtonTapped());
            }),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              context
                  .bloc<WorklogBloc>()
                  .add(const CreateManHoursChargeButtonTapped());
            }),
        IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              if (this._formKey.currentState.validate()) {
                print("send it");
                context.bloc<WorklogBloc>().add(const WorklogCreated());
              }
            })
      ]),
    ));
  }
}

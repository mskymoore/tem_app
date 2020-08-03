import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:tem_app/widgets/worklog_form.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:tem_app/widgets/loading.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';
import 'package:tem_app/bloc/worklog_form/worklog_form_bloc.dart';
import 'package:tem_app/bloc/equipcharge_form/equipcharge_form_bloc.dart';
import 'package:tem_app/bloc/manhourscharge_form/manhourscharge_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WorklogPage extends StatelessWidget {
  final String title;
  WorklogPage(this.title);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => WorklogPage('Worklogs'));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      drawer: Drawer(child: DrawerFutureBuilder()),
      appBar: AppBar(
        title: Text(this.title),
        actions: <Widget>[],
      ),
      body: BlocListener<WorklogFormBloc, WorklogFormState>(
          listener: (context, state) async {
            if (state.status.isSubmissionSuccess) {
              context
                  .bloc<EquipChargeFormBloc>()
                  .add(EquipRequiredWorklogSuccessfullySubmitted());
              context
                  .bloc<ManHoursChargeFormBloc>()
                  .add(ManHoursRequiredWorklogSuccessfullySubmitted());

              await Future.delayed(Duration(seconds: 1));
              context.bloc<WorklogBloc>().add(WorklogEvent.WorklogCreated);
            }
          },
          child: CreateWorklogForm()),
      floatingActionButton: BlocBuilder<WorklogFormBloc, WorklogFormState>(
          buildWhen: (previous, current) =>
              current.status.isSubmissionInProgress ||
              current.status.isPure ||
              current.status.isSubmissionFailure ||
              current.status.isSubmissionSuccess,
          builder: (context, state) {
            if (state.status.isPure) {
              return WorklogFormMenu();
            } else if (state.status.isSubmissionInProgress) {
              return LoadingCircleWidget(30);
            } else if (state.status.isSubmissionSuccess) {
              return Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 60,
              );
            } else if (state.status.isSubmissionFailure) {
              return FutureBuilder<String>(
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return WorklogFormMenu();
                    } else {
                      return Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 60,
                      );
                    }
                  },
                  future: Future<String>.delayed(
                      Duration(seconds: 3), () => "data"));
            } else {
              return WorklogFormMenu();
            }
          }),
    ));
  }
}

class WorklogFormMenu extends StatelessWidget {
  Widget build(BuildContext context) {
    return FabCircularMenu(children: <Widget>[
      IconButton(
          icon: Icon(Icons.local_shipping),
          onPressed: () {
            context
                .bloc<WorklogBloc>()
                .add(WorklogEvent.CreateEquipChargeButtonTapped);
          }),
      IconButton(
          icon: Icon(Icons.assignment_ind),
          onPressed: () {
            context
                .bloc<WorklogBloc>()
                .add(WorklogEvent.CreateManHoursChargeButtonTapped);
          }),
      IconButton(
          icon: Icon(Icons.send),
          onPressed: () async {
            context.bloc<WorklogFormBloc>().add(WorklogSubmitted());
          })
    ]);
  }
}

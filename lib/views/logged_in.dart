import 'package:flutter/material.dart';
import 'package:tem_app/bloc/auth/auth_bloc.dart';
import 'package:tem_app/widgets/worklog.dart';
import 'package:tem_app/views/views.dart';
import 'package:tem_app/widgets/scaffold.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/bloc/worklog_form/worklog_form_bloc.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';

class MainPage extends StatelessWidget {
  static const String title = 'Worklogs';
  static const String worklog = '/worklog';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => MainPage(), settings: RouteSettings(name: worklog));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        "Worklogs",
        Center(
            child: BlocListener<WorklogBloc, WorklogState>(
                listener: (context, state) {
                  print("MainPage listened");
                  if (state is ViewingWorklogFormState) {
                    context.bloc<WorklogFormBloc>().add(NewWorklog(
                        context.bloc<AuthenticationBloc>().state.user.id));
                    Navigator.of(context).push(WorklogPage.route());
                  } else if (state is ViewingEquipChargeFormState) {
                    Navigator.of(context).push(EquipmentPage.route());
                  } else if (state is ViewingManHoursChargeFormState) {
                    Navigator.of(context).push(ManHrsPage.route());
                  } else if (state is ValidatingEquipChargeState ||
                      state is ValidatingManHoursChargeState) {
                  } else {
                    Navigator.of(context).pop();
                  }
                },
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[WorklogFutureBuilder()]))),
        WorklogEvent.CreateWorklogButtonTapped);
  }
}

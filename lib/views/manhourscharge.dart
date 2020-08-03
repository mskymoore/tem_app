import 'package:flutter/material.dart';
import 'package:tem_app/bloc/manhourscharge_form/manhourscharge_form_bloc.dart';
import 'package:tem_app/widgets/manhrscharge_form.dart';
import 'package:tem_app/widgets/scaffold.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManHrsPage extends StatelessWidget {
  static const String createEquipCharge = '/create_manhourscharge';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ManHrsPage(),
        settings: RouteSettings(name: createEquipCharge));
  }

  ManHrsPage();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorklogBloc, WorklogState>(
        listener: (context, state) {
          print('ManHrsPage listened');
          if (state is ValidatingManHoursChargeState) {
            context.bloc<WorklogBloc>().add(WorklogEvent.ManHoursChargeCreated);
            context
                .bloc<ManHoursChargeFormBloc>()
                .add(ManHoursChargeSubmitted());
          }
        },
        child: AppScaffold("Add Man Hours", CreateManHoursChargeForm(),
            WorklogEvent.AddManHoursChargeButtonTapped));
  }
}

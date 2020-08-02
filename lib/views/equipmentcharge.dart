import 'package:flutter/material.dart';
import 'package:tem_app/widgets/equipmentcharge_form.dart';
import 'package:tem_app/widgets/scaffold.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EquipmentPage extends StatelessWidget {
  static const String createEquipCharge = '/create_equipcharge';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => EquipmentPage(),
        settings: RouteSettings(name: createEquipCharge));
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<WorklogBloc, WorklogState>(
        listener: (context, state) {
          print('EquipmentPage listened');
          if (state is ValidatingEquipChargeState) {
            if (this._formKey.currentState.validate()) {
              context.bloc<WorklogBloc>().add(WorklogEvent.EquipChargeCreated);
            }
          }
        },
        child: AppScaffold("Add Equipment Charge", CreateEquipmentChargeForm(),
            WorklogEvent.AddEquipChargeButtonTapped));
  }
}

import 'package:flutter/material.dart';
import 'package:tem_app/widgets/equipmentcharge_form.dart';
import 'package:tem_app/widgets/scaffold.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';

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
    return AppScaffold(
        "Add Equipment Charge",
        CreateEquipmentChargeForm(this._formKey),
        WorklogEvent.AddEquipChargeButtonTapped);
  }
}

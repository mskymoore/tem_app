import 'package:flutter/material.dart';
import 'package:tem_app/widgets/manhrscharge_form.dart';
import 'package:tem_app/widgets/scaffold.dart';
import 'package:tem_app/bloc/worklog/worklog_bloc.dart';

class ManHrsPage extends StatelessWidget {
  static const String createEquipCharge = '/create_manhourscharge';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ManHrsPage(),
        settings: RouteSettings(name: createEquipCharge));
  }

  ManHrsPage();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AppScaffold("Add Man Hours", CreateManHrsChargeForm(this._formKey),
        WorklogEvent.AddManHoursChargeButtonTapped);
  }
}

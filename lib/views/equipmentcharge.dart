import 'package:flutter/material.dart';
import 'package:tem_app/widgets/equipmentcharge_form.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:tem_app/config/constants.dart';

class EquipmentPage extends StatelessWidget {
  static const String createEquipCharge = '/create_equipcharge';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => EquipmentPage(),
        settings: RouteSettings(name: createEquipCharge));
  }

  Map formData = {
    hours: 0.0,
    equipment: 1,
    worklog: 0,
    dispute: null,
  };

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            drawer: Drawer(child: DrawerFutureBuilder()),
            appBar: AppBar(
              title: Text("Add Equipment Charge"),
              actions: <Widget>[],
            ),
            body: CreateEquipmentChargeForm(this._formKey),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (this._formKey.currentState.validate()) {
                  print(formData);
                }
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            )));
  }
}

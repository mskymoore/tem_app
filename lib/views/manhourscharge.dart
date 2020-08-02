import 'package:flutter/material.dart';
import 'package:tem_app/widgets/manhrscharge_form.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:tem_app/config/constants.dart';

class ManHrsPage extends StatelessWidget {
  static const String createEquipCharge = '/create_manhourscharge';
  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => ManHrsPage("Add Man Hours"),
        settings: RouteSettings(name: createEquipCharge));
  }

  final String title;
  ManHrsPage(this.title);

  Map formData = {
    hours: 0.0,
    employee: 0,
    position: "",
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
              title: Text(this.title),
              actions: <Widget>[],
            ),
            body: CreateManHrsChargeForm(this._formKey),
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

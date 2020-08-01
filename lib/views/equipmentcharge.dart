import 'package:flutter/material.dart';
import 'package:tem_app/widgets/equipmentcharge_form.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:tem_app/config/constants.dart';

class EquipmentPage extends StatefulWidget {
  final String title;
  final appendToWorklog;
  EquipmentPage(this.title, this.appendToWorklog);

  @override
  _EquipmentPageState createState() => _EquipmentPageState();
}

class _EquipmentPageState extends State<EquipmentPage> {
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
              title: Text(widget.title),
              actions: <Widget>[],
            ),
            body: CreateEquipmentChargeForm(
                (value) => {
                      setState(() {
                        this.formData = value;
                      })
                    },
                this._formKey),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (this._formKey.currentState.validate()) {
                  print(formData);
                  this.widget.appendToWorklog(formData);
                  Navigator.of(context).pop();
                }
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
            )));
  }
}

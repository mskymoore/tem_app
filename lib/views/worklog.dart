import 'package:flutter/material.dart';
import 'package:tem_app/widgets/worklog_form.dart';
import 'package:tem_app/widgets/drawer.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';

class WorklogPage extends StatefulWidget {
  final String title;
  WorklogPage(this.title);

  @override
  _WorklogPageState createState() => _WorklogPageState();
}

class _WorklogPageState extends State<WorklogPage> {
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
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: CreateWorklogForm(
          (value) => {
                setState(() {
                  this.formData = value;
                })
              },
          this._formKey),
      floatingActionButton: FabCircularMenu(children: <Widget>[
        IconButton(
            icon: Icon(Icons.assignment_ind),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/create_manhrscharge', arguments: {
                'title': 'Add Man Hours',
                'callback': (value) => {
                      setState(() {
                        this.formData['manhours_charges'].add(value);
                      })
                    }
              });
              print('add manhours charge');
            }),
        IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/create_equipcharge', arguments: {
                'title': 'Add Equipment Hours',
                'callback': (value) => {
                      setState(() {
                        this.formData['equipment_charges'].add(value);
                      })
                    }
              });
              print('add equipment charge');
            }),
        IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              if (this._formKey.currentState.validate()) {
                final prefs = await appPrefs();
                this.formData['created_by'] = prefs.getString(id);
                final List manHoursCharges = this.formData['manhours_charges'];
                final List equipmentCharges =
                    this.formData['equipment_charges'];
                this.formData['manhours_charges'] = [];
                this.formData['equipment_charges'] = [];

                manHoursCharges.forEach((element) {
                  this
                      .formData['included_employees']
                      .add(int.parse(element[employee]));
                });

                final response = await postWorklog(this.formData);

                manHoursCharges.forEach((element) {
                  element['created_by'] = prefs.getString(id);
                  element['worklog'] = response[id];
                  postManHoursCharge(element);
                });

                equipmentCharges.forEach((element) {
                  element['created_by'] = prefs.getString(id);
                  element['worklog'] = response[id];
                  postEquipmentCharge(element);
                });
                Navigator.of(context).pushReplacementNamed('/worklog');
              }
            })
      ]),
    ));
  }
}

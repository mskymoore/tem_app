import 'package:flutter/material.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/widgets/manhours.dart';
import 'package:tem_app/widgets/equipment.dart';

class CreateWorklogForm extends StatelessWidget {
  static const String _create_worklog = '/create_worklog';
  static Route route(key) {
    return MaterialPageRoute<void>(
        builder: (_) => CreateWorklogForm(key),
        settings: RouteSettings(name: _create_worklog));
  }

  CreateWorklogForm(this._formKey);
  final _formKey;

  Map formData = {
    summary: '',
    client: '',
    'created_by': '',
    'approved': 'false',
    'disputed': 'false',
    'manhours_charges': [],
    'equipment_charges': [],
    'included_employees': [1]
  };

  //final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                  maxLines: null,
                  autofocus: false,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.work),
                    hintText: 'Summarize your worklog...',
                    labelText: 'Summary',
                  ),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter a summary.';
                    }

                    return null;
                  },
                  onSaved: (value) => {}),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(Text("Choose the client"), getClients,
                      (value) => {}, name)),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(Text("Choose the region"), getRegions,
                      (value) => {}, name)),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the site"), getSites, (value) => {}, name)),
              Text("Man Hours Charges",
                  style: TextStyle(decoration: TextDecoration.underline)),
              Container(
                  child: Expanded(
                child: ManHoursList(
                    {"results": this.formData['manhours_charges']}),
              )),
              Text("Equipment Charges",
                  style: TextStyle(decoration: TextDecoration.underline)),
              Container(
                  child: Expanded(
                child: EquipmentList(
                    {"results": this.formData['equipment_charges']}),
              )),
            ])));
  }
}

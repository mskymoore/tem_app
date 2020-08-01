import 'package:flutter/material.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/widgets/manhours.dart';

class CreateWorklogForm extends StatefulWidget {
  // a callback to a parent set state to get data from form
  final sendFormData;
  final _formKey;
  CreateWorklogForm(this.sendFormData, this._formKey);

  @override
  CreateWorklogFormState createState() {
    return CreateWorklogFormState();
  }
}

class CreateWorklogFormState extends State<CreateWorklogForm> {
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

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: widget._formKey,
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
                  setState(() {
                    formData[summary] = value;
                    widget.sendFormData(formData);
                  });
                  return null;
                },
                onSaved: (value) => {
                  setState(() {
                    formData[summary] = value;
                    widget.sendFormData(formData);
                  })
                },
              ),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the client"),
                      getClients,
                      (value) => {
                            setState(() {
                              formData[client] = value;
                              widget.sendFormData(formData);
                            })
                          },
                      name)),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the region"),
                      getRegions,
                      (value) => {
                            setState(() {
                              formData[region] = value;
                              widget.sendFormData(formData);
                            })
                          },
                      name)),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the site"),
                      getSites,
                      (value) => {
                            setState(() {
                              print(formData);
                              formData[site] = value;
                              widget.sendFormData(formData);
                            })
                          },
                      name)),
              Text("Man Hours Charges",
                  style: TextStyle(decoration: TextDecoration.underline)),
              Container(
                  child: Expanded(
                child: ManHoursList(
                    {"results": this.formData['manhours_charges']}),
              )),
            ])));
  }
}

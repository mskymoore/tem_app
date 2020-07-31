import 'package:flutter/material.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';

class CreateWorklogForm extends StatefulWidget {
  // a callback to a parent set state to get data from form
  final sendFormData;

  CreateWorklogForm(this.sendFormData);

  @override
  CreateWorklogFormState createState() {
    return CreateWorklogFormState();
  }
}

class CreateWorklogFormState extends State<CreateWorklogForm> {
  final _formKey = GlobalKey<FormState>();
  Map formData = {
    'summary': '',
    'client': '',
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
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
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
                    formData['summary'] = value;
                    widget.sendFormData(formData);
                  });
                  return null;
                },
                onChanged: (value) => {
                  setState(() {
                    formData['summary'] = value;
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
                              formData['client'] = value;
                              widget.sendFormData(formData);
                            })
                          })),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the region"),
                      getRegions,
                      (value) => {
                            setState(() {
                              formData['region'] = value;
                              widget.sendFormData(formData);
                            })
                          })),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the site"),
                      getSites,
                      (value) => {
                            setState(() {
                              formData['site'] = value;
                              widget.sendFormData(formData);
                            })
                          })),
            ])));
  }
}

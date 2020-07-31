import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';

class CreateWorklogForm extends StatefulWidget {
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
    'approved': '',
    'disputed': '',
    'manhours_charges': [],
    'equipment_charges': [],
    'included_employees': []
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
                  icon: Icon(Icons.person),
                  hintText: 'Summarize your worklog...',
                  labelText: 'Summary',
                ),
                validator: (value) {
                  if (value == '') {
                    return 'Please enter a summary.';
                  }
                  setState(() {
                    formData['summary'] = value;
                  });
                  return null;
                },
              ),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(Text("Choose the client"), getClients)),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(Text("Choose the region"), getRegions)),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(Text("Choose the Site"), getSites)),
              Padding(
                  padding: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        print("worklog form validated");
                      }
                    },
                    child: Text('Submit'),
                  ))
            ])));
  }
}

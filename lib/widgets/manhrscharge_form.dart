import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';
import 'package:flutter/services.dart';

class CreateManHrsChargeForm extends StatefulWidget {
  // a callback to a parent set state to get data from form
  final sendFormData;
  final _formKey;
  CreateManHrsChargeForm(this.sendFormData, this._formKey);

  @override
  CreateManHrsChargeFormState createState() {
    return CreateManHrsChargeFormState();
  }
}

class CreateManHrsChargeFormState extends State<CreateManHrsChargeForm> {
  Map formData = {
    hours: 0.0,
    employee: 1,
    position: "electrician",
    worklog: 22,
    dispute: null,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: widget._formKey,
            child: Column(children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                maxLines: null,
                autofocus: false,
                decoration: const InputDecoration(
                  icon: Icon(Icons.hourglass_full),
                  labelText: 'Hours',
                ),
                validator: (value) {
                  if (!hoursRegExp.hasMatch(value) ||
                      double.parse(value) > 24.0) {
                    return 'Please enter up to 24 hours, e.g., 9.6, 12.3';
                  }
                  setState(() {
                    formData[hours] = double.parse(value);
                    widget.sendFormData(formData);
                  });
                  return null;
                },
                onSaved: (value) => {
                  setState(() {
                    formData[hours] = double.parse(value);
                    widget.sendFormData(formData);
                  })
                },
              ),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the $employee"),
                      getEmployees,
                      (value) => {
                            setState(() {
                              formData[employee] = value;
                              widget.sendFormData(formData);
                            })
                          },
                      id)),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(
                      Text("Choose the $position"),
                      getPositions,
                      (value) => {
                            setState(() {
                              formData[position] = value;
                              widget.sendFormData(formData);
                            })
                          },
                      name)),
            ])));
  }
}

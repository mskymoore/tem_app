import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';
import 'package:flutter/services.dart';

class CreateEquipmentChargeForm extends StatefulWidget {
  // a callback to a parent set state to get data from form
  final sendFormData;
  final _formKey;
  CreateEquipmentChargeForm(this.sendFormData, this._formKey);

  @override
  CreateEquipmentChargeFormState createState() {
    return CreateEquipmentChargeFormState();
  }
}

class CreateEquipmentChargeFormState extends State<CreateEquipmentChargeForm> {
  Map formData = {
    hours: 0.0,
    equipment: 1,
    worklog: 0,
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
                      Text("Choose the $equipment"),
                      getEquipments,
                      (value) => {
                            setState(() {
                              formData[equipment] = value;
                              widget.sendFormData(formData);
                            })
                          },
                      id)),
            ])));
  }
}

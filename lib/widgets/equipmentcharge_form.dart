import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';
import 'package:flutter/services.dart';

class CreateEquipmentChargeForm extends StatelessWidget {
  final _formKey;
  CreateEquipmentChargeForm(this._formKey);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Form(
            key: this._formKey,
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
                  return null;
                },
                onSaved: (value) => {},
              ),
              SizedBox(
                  width: double.infinity,
                  child: DropDownWidget(Text("Choose the $equipment"),
                      getEquipments, (value) => {print(value)}, id)),
            ])));
  }
}

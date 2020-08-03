import 'package:flutter/material.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/bloc/equipcharge_form/equipcharge_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/widgets/loading.dart';
import 'package:formz/formz.dart';

class CreateEquipChargeForm extends StatelessWidget {
  static const String _create_equipcharge = '/create_equipcharge';
  static Route route(key) {
    return MaterialPageRoute<void>(
        builder: (_) => CreateEquipChargeForm(),
        settings: RouteSettings(name: _create_equipcharge));
  }

  CreateEquipChargeForm();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _HoursInput(),
              const Padding(padding: EdgeInsets.all(15)),
              _EquipmentInput(),
              const Padding(padding: EdgeInsets.all(15)),
            ])));
  }
}

class _HoursInput extends StatelessWidget {
  _HoursInput();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipChargeFormBloc, EquipChargeFormState>(
        buildWhen: (previous, current) => previous.hours != current.hours,
        builder: (context, state) {
          return TextFormField(
            maxLines: null,
            autofocus: false,
            decoration: const InputDecoration(
              icon: Icon(Icons.work),
              hintText: 'How many hours?',
              labelText: 'Hours',
            ),
            onChanged: (newValue) => {
              context.bloc<EquipChargeFormBloc>().add(HoursChanged(newValue)),
            },
          );
        });
  }
}

class _EquipmentInput extends StatefulWidget {
  String equipmentValue;
  _EquipmentInput();

  @override
  _EquipmentInputState createState() => _EquipmentInputState();
}

class _EquipmentInputState extends State<_EquipmentInput> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipChargeFormBloc, EquipChargeFormState>(
        buildWhen: (previous, current) =>
            previous.equipment != current.equipment,
        builder: (context, state) {
          return SizedBox(
              width: double.infinity,
              child: FutureBuilder<Map>(
                  future: getEquipments(),
                  builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                    if (snapshot.hasData) {
                      List<DropdownMenuItem<String>> theItems =
                          List<DropdownMenuItem<String>>();
                      for (var i = 0; i < snapshot.data[results].length; i++) {
                        theItems.add(DropdownMenuItem(
                            value: "${snapshot.data[results][i][name]}",
                            child: Text(
                              "${snapshot.data[results][i][name]}",
                            )));
                      }
                      return DropdownButton<String>(
                        value: dropdownValue,
                        hint: Text("Choose the equipment"),
                        icon: Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          context
                              .bloc<EquipChargeFormBloc>()
                              .add(EquipChanged(newValue));
                          setState(() {
                            this.dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: theItems,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Text("An error occurred loading equipments.");
                    } else {
                      return LoadingCircleWidget(20.0);
                    }
                  }));
        });
  }
}

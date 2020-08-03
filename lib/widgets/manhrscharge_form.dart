import 'package:flutter/material.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/bloc/manhourscharge_form/manhourscharge_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/widgets/loading.dart';

class CreateManHoursChargeForm extends StatelessWidget {
  static const String _create_manhourscharge = '/create_manhourscharge';
  static Route route(key) {
    return MaterialPageRoute<void>(
        builder: (_) => CreateManHoursChargeForm(),
        settings: RouteSettings(name: _create_manhourscharge));
  }

  CreateManHoursChargeForm();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Align(
            alignment: const Alignment(0, -1 / 3),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _HoursInput(),
              const Padding(padding: EdgeInsets.all(15)),
              _EmployeeInput(),
              const Padding(padding: EdgeInsets.all(15)),
              _PositionInput(),
              const Padding(padding: EdgeInsets.all(15)),
            ])));
  }
}

class _HoursInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManHoursChargeFormBloc, ManHoursChargeFormState>(
        buildWhen: (previous, current) => previous.hours != current.hours,
        builder: (context, state) {
          return TextField(
            maxLines: null,
            autofocus: false,
            decoration: InputDecoration(
              icon: Icon(Icons.timer),
              hintText: 'How many hours?',
              labelText: 'Hours',
              errorText: state.hours.invalid
                  ? 'Please enter up to 24 hours, e.g., 9.6, 12.3'
                  : null,
            ),
            onChanged: (hours) => {
              context.bloc<ManHoursChargeFormBloc>().add(HoursChanged(hours))
            },
          );
        });
  }
}

class _EmployeeInput extends StatefulWidget {
  String employeeValue;
  _EmployeeInput();

  @override
  _EmployeeInputState createState() => _EmployeeInputState();
}

class _EmployeeInputState extends State<_EmployeeInput> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManHoursChargeFormBloc, ManHoursChargeFormState>(
        buildWhen: (previous, current) => previous.employee != current.employee,
        builder: (context, state) {
          return SizedBox(
              width: double.infinity,
              child: FutureBuilder<Map>(
                  future: getEmployees(),
                  builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                    if (snapshot.hasData) {
                      List<DropdownMenuItem<String>> theItems =
                          List<DropdownMenuItem<String>>();
                      for (var i = 0; i < snapshot.data[results].length; i++) {
                        theItems.add(DropdownMenuItem(
                            value: "${snapshot.data[results][i][id]}",
                            child: Text(
                              "${snapshot.data[results][i][id]}",
                            )));
                      }
                      return DropdownButton<String>(
                        value: dropdownValue,
                        hint: Text("Choose the employee"),
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
                              .bloc<ManHoursChargeFormBloc>()
                              .add(EmployeeChanged(newValue));
                          setState(() {
                            this.dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: theItems,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Text("An error occurred loading employees.");
                    } else {
                      return LoadingCircleWidget(20.0);
                    }
                  }));
        });
  }
}

class _PositionInput extends StatefulWidget {
  String positionValue;
  _PositionInput();

  @override
  _PositionInputState createState() => _PositionInputState();
}

class _PositionInputState extends State<_PositionInput> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManHoursChargeFormBloc, ManHoursChargeFormState>(
        buildWhen: (previous, current) => previous.position != current.position,
        builder: (context, state) {
          return SizedBox(
              width: double.infinity,
              child: FutureBuilder<Map>(
                  future: getPositions(),
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
                        hint: Text("Choose the position"),
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
                              .bloc<ManHoursChargeFormBloc>()
                              .add(PositionChanged(newValue));
                          setState(() {
                            this.dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: theItems,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Text("An error occurred loading positions.");
                    } else {
                      return LoadingCircleWidget(20.0);
                    }
                  }));
        });
  }
}

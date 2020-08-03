import 'package:flutter/material.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/widgets/manhours.dart';
import 'package:tem_app/widgets/equipment.dart';
import 'package:tem_app/bloc/worklog_form/worklog_form_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/widgets/loading.dart';
import 'package:tem_app/models/models.dart';

class CreateWorklogForm extends StatelessWidget {
  static const String _create_worklog = '/create_worklog';
  static Route route(key) {
    return MaterialPageRoute<void>(
        builder: (_) => CreateWorklogForm(),
        settings: RouteSettings(name: _create_worklog));
  }

  CreateWorklogForm();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(30),
        child: Align(
            alignment: const Alignment(0, -1),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              _SummaryInput(),
              const Padding(padding: EdgeInsets.all(1)),
              _ClientInput(),
              const Padding(padding: EdgeInsets.all(1)),
              _RegionInput(),
              const Padding(padding: EdgeInsets.all(1)),
              _SiteInput(),
              const Padding(padding: EdgeInsets.all(1)),
            ])));
  }
}

class _SummaryInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorklogFormBloc, WorklogFormState>(
        buildWhen: (previous, current) => previous.summary != current.summary,
        builder: (context, state) {
          return TextField(
              maxLines: null,
              autofocus: false,
              decoration: const InputDecoration(
                icon: Icon(Icons.work),
                hintText: 'Summarize your worklog...',
                labelText: 'Summary',
              ));
        });
  }
}

class _ClientInput extends StatefulWidget {
  String clientValue;
  _ClientInput();

  @override
  _ClientInputState createState() => _ClientInputState();
}

class _ClientInputState extends State<_ClientInput> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorklogFormBloc, WorklogFormState>(
        buildWhen: (previous, current) => previous.client != current.client,
        builder: (context, state) {
          return SizedBox(
              width: double.infinity,
              child: FutureBuilder<Map>(
                  future: getClients(),
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
                        hint: Text("Choose the client"),
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
                              .bloc<WorklogFormBloc>()
                              .add(ClientChanged(newValue));
                          setState(() {
                            this.dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: theItems,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Text("An error occurred loading clients.");
                    } else {
                      return LoadingCircleWidget(20.0);
                    }
                  }));
        });
  }
}

class _RegionInput extends StatefulWidget {
  _RegionInput();

  @override
  _RegionInputState createState() => _RegionInputState();
}

class _RegionInputState extends State<_RegionInput> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorklogFormBloc, WorklogFormState>(
        buildWhen: (previous, current) => previous.region != current.region,
        builder: (context, state) {
          return SizedBox(
              width: double.infinity,
              child: FutureBuilder<Map>(
                  future: getRegions(),
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
                        hint: Text("Choose the region"),
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
                              .bloc<WorklogFormBloc>()
                              .add(RegionChanged(newValue));
                          setState(() {
                            this.dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: theItems,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Text("An error occurred loading regions.");
                    } else {
                      return LoadingCircleWidget(20.0);
                    }
                  }));
        });
  }
}

class _SiteInput extends StatefulWidget {
  _SiteInput();

  @override
  _SiteInputState createState() => _SiteInputState();
}

class _SiteInputState extends State<_SiteInput> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorklogFormBloc, WorklogFormState>(
        buildWhen: (previous, current) => previous.site != current.site,
        builder: (context, state) {
          return SizedBox(
              width: double.infinity,
              child: FutureBuilder<Map>(
                  future: getSites(),
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
                        hint: Text("Choose the site"),
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
                              .bloc<WorklogFormBloc>()
                              .add(SiteChanged(newValue));
                          setState(() {
                            this.dropdownValue = newValue;
                          });
                        },
                        isExpanded: true,
                        items: theItems,
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      return Text("An error occurred loading sites.");
                    } else {
                      return LoadingCircleWidget(20.0);
                    }
                  }));
        });
  }
}

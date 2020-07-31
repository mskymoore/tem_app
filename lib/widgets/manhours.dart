import 'package:flutter/material.dart';
import 'package:tem_app/widgets/loading.dart';
import 'package:tem_app/rest/api.dart';

class ManHoursFutureBuilder extends StatelessWidget {
  ManHoursFutureBuilder();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: FutureBuilder<Map>(
              future: getManHours(),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  return ManHoursList(snapshot.data);
                } else {
                  return LoadingCircleWidget(108.0);
                }
              })),
    );
  }
}

class ManHoursList extends StatelessWidget {
  final Map manHours;
  ManHoursList(this.manHours);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.manHours['results'].length,
      itemBuilder: (BuildContext context, int index) {
        return ManHoursCard(this.manHours['results'][index]);
      },
    );
  }
}

class ManHoursCard extends StatelessWidget {
  final Map manHoursCharge;
  ManHoursCard(this.manHoursCharge);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print("tapped dat"),
        child: SafeArea(
            child: Card(
                child: ListTile(
          title: Text("${this.manHoursCharge['date']}"),
          subtitle: Row(children: <Widget>[
            Column(children: <Widget>[
              Text("emp# ${this.manHoursCharge['employee']}")
            ]),
            Column(children: <Widget>[
              Text(": ${this.manHoursCharge['hours']} hours")
            ]),
            Column(children: <Widget>[
              Text(" as ${this.manHoursCharge['position']}")
            ]),
          ]),
        ))));
  }
}

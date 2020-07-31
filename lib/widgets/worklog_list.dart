import 'package:flutter/material.dart';
import 'package:tem_app/widgets/loading.dart';
import 'package:tem_app/rest/api.dart';

class WorklogFutureBuilder extends StatelessWidget {
  WorklogFutureBuilder();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: FutureBuilder<Map>(
              future: getWorklogs(),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  return WorklogList(snapshot.data);
                } else {
                  return LoadingCircleWidget(108.0);
                }
              })),
    );
  }
}

class WorklogList extends StatelessWidget {
  final Map worklogs;
  WorklogList(this.worklogs);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.worklogs['results'].length,
      itemBuilder: (BuildContext context, int index) {
        return WorklogCard(this.worklogs['results'][index]);
      },
    );
  }
}

class WorklogCard extends StatelessWidget {
  final Map worklog;
  WorklogCard(this.worklog);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print("tapped dat"),
        child: Card(
            child: ListTile(
          title: Text("${this.worklog['date']} - ${this.worklog['summary']}"),
          subtitle: Row(children: <Widget>[
            Column(children: <Widget>[Text("${this.worklog['client']}")]),
            Column(children: <Widget>[Text(" - ${this.worklog['site']}")]),
            Column(children: <Widget>[
              Text(" - created by ${this.worklog['created_by']['username']}")
            ]),
          ]),
        )));
  }
}

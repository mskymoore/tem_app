import 'package:flutter/material.dart';

class WorklogList extends StatelessWidget {
  final Map worklogs;
  WorklogList(this.worklogs);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.worklogs['results'].length,
      itemBuilder: (BuildContext context, int index) {
        return WorklogCard(this.worklogs, index);
      },
    );
  }
}

class WorklogCard extends StatelessWidget {
  final Map worklogs;
  final int index;
  WorklogCard(this.worklogs, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print("tapped dat"),
        child: Card(
            child: ListTile(
          title: Text(
              "${this.worklogs['results'][index]['date']} - ${this.worklogs['results'][index]['summary']}"),
          subtitle: Row(children: <Widget>[
            Column(children: <Widget>[
              Text("${this.worklogs['results'][index]['client']}")
            ]),
            Column(children: <Widget>[
              Text(" - ${this.worklogs['results'][index]['site']}")
            ]),
            Column(children: <Widget>[
              Text(
                  " - created by ${this.worklogs['results'][index]['created_by']['username']}")
            ]),
          ]),
        )));
    ;
  }
}

  }
}

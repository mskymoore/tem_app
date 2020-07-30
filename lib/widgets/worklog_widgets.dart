import 'package:flutter/material.dart';

class WorklogList extends StatelessWidget {
  Map worklogs = {'results': []};
  WorklogList(worklogs) {
    this.worklogs = worklogs;
  }

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
  Map worklogs = {'results': []};
  int index = 0;
  WorklogCard(worklogs, index) {
    this.worklogs = worklogs;
    this.index = index;
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print("tapped dat"),
        child: Card(
            child: Column(children: <Widget>[
          Text("${this.worklogs['results'][index]['summary']}"),
          Text("${this.worklogs['results'][index]['client']}"),
          Text("${this.worklogs['results'][index]['site']}"),
        ])));
  }
}

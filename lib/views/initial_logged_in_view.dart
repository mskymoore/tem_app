import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/rest/auth.dart';
import 'package:tem_app/views/login_view.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/widgets/worklog_widgets.dart';

class MainPage extends StatefulWidget {
  final String title;
  Map worklogs;
  MainPage(this.title);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: FutureBuilder<Map>(
              future: usersMe(),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: <Widget>[
                      UserAccountsDrawerHeader(
                        accountName: Text(
                            "${snapshot.data[firstName]} ${snapshot.data[lastName]}"),
                        accountEmail: Text(snapshot.data[username]),
                        currentAccountPicture: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).platform == TargetPlatform.iOS
                                  ? Colors.blue
                                  : Colors.white,
                          child: Text(
                            snapshot.data[firstName][0],
                            style: TextStyle(fontSize: 40.0),
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text("Refresh"),
                        trailing: Icon(Icons.arrow_forward),
                      ),
                      ListTile(
                          title: Text("Logout"),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            Navigator.of(context).pop();
                            tokenLogout();
                            Navigator.of(context)
                                .pop(LoginPage(title: "TEM APP BETA"));
                          }),
                    ],
                  );
                } else {
                  return Center(
                      child: SizedBox(
                          height: 108.0,
                          width: 108.0,
                          child: CircularProgressIndicator()));
                }
              })),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: FutureBuilder<Map>(
                    future: getWorklogs(),
                    builder:
                        (BuildContext context, AsyncSnapshot<Map> snapshot) {
                      if (snapshot.hasData) {
                        return WorklogList(snapshot.data);
                      } else {
                        return Center(
                            child: SizedBox(
                                height: 108.0,
                                width: 108.0,
                                child: CircularProgressIndicator()));
                      }
                    }))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            widget.worklogs = {'results': []};
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

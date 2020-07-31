import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/rest/auth.dart';
import 'package:tem_app/views/login_view.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/widgets/worklog_widgets.dart';

class MainPage extends StatefulWidget {
  final String title;
  final String userName;
  final String accountName;
  Map worklogs;
  MainPage(this.title, this.userName, this.accountName, this.worklogs);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.accountName),
              accountEmail: Text(widget.userName),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  widget.accountName[0],
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
                  Navigator.of(context).pop(LoginPage(title: "TEM APP BETA"));
                }),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child: WorklogList(widget.worklogs)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final worklogs = await getWorklogs();
          setState(() {
            widget.worklogs = worklogs;
          });
        },
        child: Icon(Icons.replay),
        backgroundColor: Colors.green,
      ),
    );
  }
}

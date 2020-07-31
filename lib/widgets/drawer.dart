import 'package:flutter/material.dart';
import 'package:tem_app/config/constants.dart';
import 'package:tem_app/rest/auth.dart';
import 'package:tem_app/views/login.dart';
import 'package:tem_app/widgets/loading.dart';
import 'package:tem_app/views/client.dart';

class DrawerFutureBuilder extends StatelessWidget {
  DrawerFutureBuilder();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Map>(
          future: usersMe(),
          builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
            if (snapshot.hasData) {
              return DrawerContentsWidget(snapshot.data);
            } else {
              return LoadingCircleWidget(108.0);
            }
          }),
    );
  }
}

class DrawerContentsWidget extends StatelessWidget {
  final Map user;
  DrawerContentsWidget(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("${user[firstName]} ${user[lastName]}"),
            accountEmail: Text(user[username]),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                user[firstName][0],
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
              title: Text("Clients"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ClientPage(
                          'TEM APP BETA',
                        )));
              }),
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
    );
  }
}

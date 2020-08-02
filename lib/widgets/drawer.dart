import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tem_app/bloc/auth/auth_bloc.dart';
import 'package:tem_app/views/views.dart';

class DrawerFutureBuilder extends StatelessWidget {
  DrawerFutureBuilder();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DrawerContentsWidget(),
    );
  }
}

class DrawerContentsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName:
                Text('${context.bloc<AuthenticationBloc>().state.user.name}'),
            accountEmail:
                Text('${context.bloc<AuthenticationBloc>().state.user.email}'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).platform == TargetPlatform.iOS
                  ? Colors.blue
                  : Colors.white,
              child: Text(
                '${context.bloc<AuthenticationBloc>().state.user.name[0]}',
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          ListTile(
              title: Text("Info"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
              }),
          ListTile(
              title: Text("Worklogs"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .pushAndRemoveUntil(MainPage.route(), (route) => false);
              }),
          ListTile(
              title: Text("Add Client"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                print("add client");
              }),
          ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.of(context).pop();
                context
                    .bloc<AuthenticationBloc>()
                    .add(AuthenticationLogoutRequested());
              }),
        ],
      ),
    );
  }
}

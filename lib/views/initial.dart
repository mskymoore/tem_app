import 'package:flutter/material.dart';
import 'package:tem_app/rest/auth.dart';
import 'package:tem_app/views/login.dart';
import 'package:tem_app/views/logged_in.dart';
import 'package:tem_app/widgets/loading.dart';

class IsLoginRequired extends StatelessWidget {
  const IsLoginRequired();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<Map>(
        future: usersMe(),
        builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
          if (snapshot.hasData) {
            return MainPage("TEM APP BETA");
          } else if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage(title: "TEM LOG IN");
          } else {
            return LoadingCircleWidget(108.0);
          }
        },
      ),
    );
  }
}

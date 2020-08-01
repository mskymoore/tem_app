import 'package:flutter/material.dart';
import 'package:tem_app/rest/auth.dart';
import 'package:tem_app/views/views.dart';
import 'package:tem_app/models/models.dart';
import 'package:tem_app/widgets/loading.dart';

class IsLoginRequired extends StatelessWidget {
  const IsLoginRequired();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder<User>(
        future: usersMe(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            return MainPage();
          } else if (snapshot.connectionState == ConnectionState.done) {
            return LoginPage();
          } else {
            return LoadingCircleWidget(108.0);
          }
        },
      ),
    );
  }
}

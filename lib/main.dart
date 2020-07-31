import 'package:flutter/material.dart';
import 'package:tem_app/config/routes.dart';

void main() {
  runApp(TemApp());
}

class TemApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Tem App Beta',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/',
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}

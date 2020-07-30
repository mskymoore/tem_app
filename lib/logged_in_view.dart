import 'package:flutter/material.dart';
import 'package:tem_app/auth.dart';
import 'package:tem_app/login_view.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: 'Logout',
            onPressed: () async {
              FutureBuilder(
                  future: tokenLogout(),
                  builder: (context, snapshot) {
                    print("called logout builder");
                  });
              Navigator.of(context).pop(LoginPage(title: "TEM APP BETA"));
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Logged In"),
          ],
        ),
      ),
    );
  }
}

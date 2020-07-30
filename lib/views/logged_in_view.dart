import 'package:flutter/material.dart';
import 'package:tem_app/rest/auth.dart';
import 'package:tem_app/views/login_view.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/widgets/worklog_widgets.dart';

Route mainPageRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MainPage(
      title: "TEM APP BETA",
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Map worklogs = {'results': []};
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
            Expanded(child: WorklogList(this.worklogs)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final worklogs = await getWorklogs();
          setState(() {
            this.worklogs = worklogs;
          });
        },
        child: Icon(Icons.replay),
        backgroundColor: Colors.green,
      ),
    );
  }
}

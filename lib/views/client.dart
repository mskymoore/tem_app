import 'package:flutter/material.dart';
import 'package:tem_app/widgets/scaffold.dart';
import 'package:tem_app/widgets/dropdown.dart';
import 'package:tem_app/rest/api.dart';

class ClientPage extends StatefulWidget {
  final String title;
  ClientPage(this.title);

  @override
  _ClientPageState createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return TemScaffold(
      "TEM APP BETA",
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropDownWidget(Text("Clients"), getClients),
          ],
        ),
      ),
    );
  }
}

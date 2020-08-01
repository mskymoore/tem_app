import 'package:flutter/material.dart';
import 'package:tem_app/widgets/loading.dart';
import 'package:tem_app/rest/api.dart';
import 'package:tem_app/config/constants.dart';

class EquipmentFutureBuilder extends StatelessWidget {
  EquipmentFutureBuilder();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: FutureBuilder<Map>(
              future: getEquipments(),
              builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
                if (snapshot.hasData) {
                  return EquipmentList(snapshot.data);
                } else {
                  return LoadingCircleWidget(108.0);
                }
              })),
    );
  }
}

class EquipmentList extends StatelessWidget {
  final Map equipment;
  EquipmentList(this.equipment);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.equipment[results].length,
      itemBuilder: (BuildContext context, int index) {
        return EquipmentCard(this.equipment[results][index]);
      },
    );
  }
}

class EquipmentCard extends StatelessWidget {
  final Map equipmentCharge;
  EquipmentCard(this.equipmentCharge);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => print("tapped dat"),
        child: SafeArea(
            child: Card(
                child: ListTile(
          title: Row(children: <Widget>[
            Column(children: <Widget>[
              Text("equipment# ${this.equipmentCharge['equipment']}")
            ]),
            Column(children: <Widget>[
              Text(": ${this.equipmentCharge['hours']} hours")
            ]),
          ]),
        ))));
  }
}

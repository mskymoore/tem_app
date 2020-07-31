import 'package:flutter/material.dart';
import 'package:tem_app/widgets/loading.dart';

class DropDownWidget extends StatefulWidget {
  final Text hint;
  final dropDownFuture;
  DropDownWidget(this.hint, this.dropDownFuture);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<Map>(
            future: widget.dropDownFuture(),
            builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
              if (snapshot.hasData) {
                List<DropdownMenuItem<String>> theItems =
                    List<DropdownMenuItem<String>>();
                for (var i = 0; i < snapshot.data['results'].length; i++) {
                  theItems.add(DropdownMenuItem(
                      value: snapshot.data['results'][i]['name'],
                      child: Text(snapshot.data['results'][i]['name'])));
                }
                return DropdownButton<String>(
                  value: dropdownValue,
                  hint: widget.hint,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: theItems,
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Text("An error occurred.");
              } else {
                return LoadingCircleWidget(20.0);
              }
            }));
  }
}

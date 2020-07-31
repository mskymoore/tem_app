import 'package:flutter/material.dart';

class LoadingCircleWidget extends StatelessWidget {
  final double square;
  LoadingCircleWidget(this.square);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: SizedBox(
              height: this.square,
              width: this.square,
              child: CircularProgressIndicator())),
    );
  }
}

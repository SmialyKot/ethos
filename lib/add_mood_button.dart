import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// Przycisk do dodawania nastroju
class AddMood extends StatelessWidget {
  AddMood({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 11.0, horizontal: 11.0),
        child: Container(
            width: 65.0,
            height: 65.0,
            child: RawMaterialButton(
              shape: CircleBorder(),
              onPressed: onPressed,
              enableFeedback: true,
              fillColor: Colors.blueAccent,
              splashColor: Colors.blue,
              child: Icon(
                Icons.add_chart,
                color: Colors.black45,
                size: 40.0,
              ),
            )));
  }
}

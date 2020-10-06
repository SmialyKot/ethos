import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AddMood extends StatelessWidget {
  AddMood({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: onPressed,
        enableFeedback: true,
        fillColor: Colors.blueAccent,
        splashColor: Colors.cyan,
        shape: new CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.add_chart,
                color: Colors.black,
              ),
            ],

          )
        ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

openMoodSlider(context) {
  Alert(
      context: context,
      title: "Jak się czujesz?",
      content: Column(
        children: <Widget>[Text('Jak tam samopoczucie?')],
      ),
      buttons: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Dodaj'),
        ),
      ]).show();
}

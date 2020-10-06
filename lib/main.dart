import 'package:flutter/material.dart';
import 'add_mood_button.dart';

void main() => runApp(Ethos());

class Ethos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(title: Text('Ethos'),
        ),
        body: Container(
          color: Colors.white60,
        ),
        floatingActionButton: AddMood(
          onPressed: null,

        ),
      )
    );
  }
}

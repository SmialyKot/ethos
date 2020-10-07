import 'package:flutter/material.dart';
import 'add_mood_button.dart';

void main() => runApp(Ethos());

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


void openMenu(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Text('Nothing yet'),
    );
  }));
}

class Ethos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Colors.indigo),
        home: Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text('Ethos'),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  openMenu(context);
                },
                tooltip: 'Menu',
              )
            ],
          ),
          body: Container(
            color: Colors.white60,
          ),
          floatingActionButton: AddMood(
            onPressed: null,
          ),
        ));
  }
}


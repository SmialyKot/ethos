import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'databaseFiles/database_helpers.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: ListView(
      children: ListTile.divideTiles(
        context: context,
        color: Colors.black45,
        tiles: [
          ListTile(
            title: Text("Usuń bazę danych"),
            trailing: Icon(Icons.delete_forever),
            onTap: (){
              Alert(
                context: context,
                type: AlertType.warning,
                title: "Usuwanie bazy danych",
                desc: "Uwaga! Potwierdzenie skutkuje wyczyszczeniem danych!",
                buttons: [
                  DialogButton(
                      child: Text("Kontynuuj"),
                      onPressed: () {
                        deleteDatabase();
                        Navigator.pop(context);
                      })
                ]
              ).show();

            },
          ),
          ListTile(
            title: Text('Dodaj przypomnienia'),
            trailing: Icon(Icons.calendar_today_outlined),
            //TODO faktyczne przypomnienia
          ),
          ListTile(
            title: Text('O aplikacji'),
            trailing: Icon(Icons.info_outline_rounded),
            //TODO faktyczne informacje
          ),
        ],
      ).toList(),
    ));
  }
}

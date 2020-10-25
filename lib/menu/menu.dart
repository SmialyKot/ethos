import 'package:Ethos/menu/data_list.dart';
import 'package:Ethos/menu/notifications.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../databaseFiles/database_helpers.dart';


class Menu extends StatelessWidget {
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
            title: Text('Dane szczegółowe'),
            trailing: Icon(Icons.format_line_spacing_rounded),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DataList();
                  }),
              );
            },
          ),
          NotificationSchedule(),
          ListTile(
            title: Text('Usuń wszystkie przypomnienia'),
            trailing: Icon(Icons.auto_delete_outlined),
            onTap: () {
              Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Usuwanie przypomnień",
                  desc: "Uwaga! Potwierdzenie skutkuje usunięciem przypomnień!",
                  buttons: [
                    DialogButton(
                        child: Text("Kontynuuj"),
                        onPressed: () {
                          NotificationScheduleState().deleteNotifications();
                          Navigator.pop(context);
                        })
                  ]
              ).show();
            },
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

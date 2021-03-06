import 'package:Ethos/menu/data_list.dart';
import 'package:Ethos/menu/notifications.dart';
import 'package:Ethos/menu/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../databaseFiles/database_helpers.dart';



// Menu aplikacji
class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: ListView(
      children: ListTile.divideTiles(
        context: context,
        color: Colors.black45,
        tiles: [
          ListTile(
            title: const Text("Usuń bazę danych"),
            trailing: const Icon(Icons.delete_forever),
            onTap: (){
              Alert(
                context: context,
                type: AlertType.warning,
                title: "Usuwanie bazy danych",
                desc: "Uwaga! Potwierdzenie skutkuje wyczyszczeniem danych!",
                buttons: [
                  DialogButton(
                      child: const Text("Kontynuuj"),
                      onPressed: () {
                        deleteDatabase();
                        Navigator.pop(context);
                      })
                ]
              ).show();

            },
          ),
          ListTile(
            title: const Text('Dane szczegółowe'),
            trailing: const Icon(Icons.format_line_spacing_rounded),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DataList();
                  }),
              );
            },
          ),
          TimePicker(),
          ListTile(
            title: const Text('Usuń wszystkie przypomnienia'),
            trailing: const Icon(Icons.auto_delete_outlined),
            onTap: () {
              Alert(
                  context: context,
                  type: AlertType.warning,
                  title: "Usuwanie przypomnień",
                  desc: "Uwaga! Potwierdzenie skutkuje usunięciem przypomnień!",
                  buttons: [
                    DialogButton(
                        child: const Text("Kontynuuj"),
                        onPressed: () {
                          NotificationSchedule().deleteNotifications();
                          Navigator.pop(context);
                        })
                  ]
              ).show();
            },
          ),
          ListTile(
            title: const Text('O aplikacji'),
            trailing: const Icon(Icons.info_outline_rounded),
            onTap: () {
              Alert(
                  context: context,
                  type: AlertType.none,
                  title: "Ethos",
                  desc: "Wykonał: Miłosz Kałucki\n"
                      "Ikony: www.icons8.com\n"
                      "#WorkInProgress",
                  buttons: [
                    DialogButton(
                        child: const Text("Powrót"),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ]
              ).show();
            },
          ),
        ],
      ).toList(),
    ));
  }
}

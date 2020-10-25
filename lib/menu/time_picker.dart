import 'package:Ethos/menu/notifications.dart';
import 'package:flutter/material.dart';

// Widget wybierania godziny
class TimePicker extends StatelessWidget {

  Future<Null>selectTime(BuildContext context) async{
    TimeOfDay _time = TimeOfDay.now();
    TimeOfDay picked = await showTimePicker(context: context, initialTime: _time, );
    if(picked != null){
      final now = new DateTime.now();
      NotificationSchedule().setNotification(DateTime(now.year, now.month, now.day, picked.hour, picked.minute),
          "Hej, tutaj Ethos!", "Nie zapomnij dodać nastroju w aplikacji!", 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text('Dodaj dzienne przypomnienia'),
      trailing: const Icon(Icons.calendar_today_outlined),
      onTap: () {
        selectTime(context);
      },
    );

  }
}

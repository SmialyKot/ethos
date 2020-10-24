import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NotificationSchedule extends StatefulWidget {
  @override
  NotificationScheduleState createState() => NotificationScheduleState();
}

class NotificationScheduleState extends State<NotificationSchedule> {


  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    const AndroidInitializationSettings initAndroid =
        AndroidInitializationSettings('zen_symbol_48');
    final IOSInitializationSettings initIOS = IOSInitializationSettings();
    final InitializationSettings initSettings = InitializationSettings(
      android: initAndroid,
      iOS: initIOS,
    );
    tz.initializeTimeZones();
    localNotificationsPlugin.initialize(
      initSettings,
    );
  }

  void deleteNotifications() async {
    await localNotificationsPlugin.cancelAll();
  }

  Future setNotification(
      DateTime datetime, String title, String text, int hashcode) async {
    var androidChannel = AndroidNotificationDetails(
      'channel-id',
      'channel-name',
      'channel-description',
      importance: Importance.max,
      priority: Priority.max,
    );

    var iosChannel = IOSNotificationDetails();
    var platformChannel =
        NotificationDetails(android: androidChannel, iOS: iosChannel);
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
    await localNotificationsPlugin.zonedSchedule(
        hashcode,
        title,
        text,
        _nextInstanceOfDate(datetime),
        platformChannel,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  tz.TZDateTime _nextInstanceOfDate(DateTime selectedDate) {
    final tz.TZDateTime now = tz.TZDateTime.from(selectedDate,tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, now.hour, now.minute, now.second);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Dodaj przypomnienia'),
      trailing: Icon(Icons.calendar_today_outlined),
      onTap: () {
        DatePicker.showTimePicker(
          context,
          showTitleActions: true,
          onConfirm: (date) {
            setNotification(date, "Hej, tutaj Ethos!", "Nie zapomnij dodać jak się czujesz", 0);
          },
          currentTime: DateTime.now(),
          locale: LocaleType.pl,
        );
      },
    );
  }
}

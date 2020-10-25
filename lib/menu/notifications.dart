import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

// Notyfikacje
class NotificationSchedule{

  FlutterLocalNotificationsPlugin localNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  void init(){
  final AndroidInitializationSettings initAndroid =
        AndroidInitializationSettings('zen_symbol_48');
  final IOSInitializationSettings initIOS = IOSInitializationSettings();
  final InitializationSettings initSettings = InitializationSettings(
      android: initAndroid,
      iOS: initIOS,);
  tz.initializeTimeZones();
  localNotificationsPlugin.initialize(initSettings,);
  }



  void deleteNotifications() async {
    await localNotificationsPlugin.cancelAll();
  }

  Future setNotification(
      DateTime datetime, String title, String text, int hashcode) async {
    var androidChannel = AndroidNotificationDetails(
      '0',
      'Przypomnienia',
      'Wyświetlanie zaplanowanych przypomnień',
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
    final tz.TZDateTime userDate = tz.TZDateTime.from(selectedDate,tz.local);
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, userDate.year, userDate.month, userDate.day, userDate.hour, userDate.minute, userDate.second);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}

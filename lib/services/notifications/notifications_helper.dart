import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  static String? selectedNotificationPayload;

  static late AndroidInitializationSettings initializationSettingsAndroid;
  static late InitializationSettings initializationSettings;

  static const IOSInitializationSettings initIOSSettings =
      IOSInitializationSettings(
    requestSoundPermission: true,
    requestBadgePermission: true,
    requestAlertPermission: true,
    // onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
  );

//NOTE initialize notification
  static Future init() async {
    notifications = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid =
        const AndroidInitializationSettings("@mipmap/launcher_icon");
    initializationSettings = InitializationSettings(
      android: NotificationApi.initializationSettingsAndroid,
      iOS: initIOSSettings,
    );

    tz.initializeTimeZones();
  }

  static Future _notificationDetails(channelId) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        //NOTE each task has channel  so channel id is the task id
        '$channelId',
        '$channelId Notifications',
        channelDescription: '$channelId Description',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  static Future shownotification(
      {int id = 0, String? title, String? body, String? payload}) async {
    notifications.show(
        id, title, body, await _notificationDetails("channel Id"),
        payload: payload);
  }

  static Future scheduleNotification(
      {required DateTime scheduleDate,
      taskChannelId,
      required String desc,
      required String title,
      required String time}) async {
    notifications = FlutterLocalNotificationsPlugin();
    await notifications.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {}
      //
    });
    await notifications.zonedSchedule(
        taskChannelId ?? 0,
        title,
        desc,
        tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(taskChannelId),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }
}

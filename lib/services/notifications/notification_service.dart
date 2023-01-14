import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:procrasti_buddy/utils/utils.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initNotification() async {
    _configureLocalTimeZone();
    const IOSInitializationSettings initIOSSettings = IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      // onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
    );

    const AndroidInitializationSettings initAndroidSettings =
        AndroidInitializationSettings("@mipmap/launcher_icon");

    const InitializationSettings initializationSettings =
        InitializationSettings(
      iOS: initIOSSettings,
      android: initAndroidSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: _onSelectNotification,
    );
  }

  Future _onSelectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> scheduleNotification(
      {int? id,
      required String title,
      required String desc,
      required DateTime date}) async {
    try {
      await _flutterLocalNotificationsPlugin.zonedSchedule(
        id ?? 0,
        title,
        desc,
        _convertTime(date.getOnlyTime, date.toString()),
        const NotificationDetails(
          iOS: IOSNotificationDetails(),
          android: AndroidNotificationDetails("channelId", "channelName"),
        ),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: '$id',
      );
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> requestIOSPermission() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  tz.TZDateTime _convertTime(String time, String date) {
    DateTime date = DateFormat.jm().parse(time);
    var myTime = DateFormat("HH:mm").format(date);
    final int hour = int.parse(myTime.split(':')[0]);
    final int min = int.parse(myTime.split(':')[1]);

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, min);
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timezone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezone));
  }
}

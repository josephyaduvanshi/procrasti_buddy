import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:procrasti_buddy/services/notifications/notifications_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          final g = await NotificationApi.allNotifications();
          print(g.length);
          for (var i in g) {
            print(i.body);
            print(i.title);
            print(i.payload);
          }
        },
        child: "Hek".text.make(),
      ),
      body: FutureBuilder<List<PendingNotificationRequest>>(
          future: NotificationApi.allNotifications(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator.adaptive();
            }
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return ListTile(
                    title: snapshot.data?[index].title.toString().text.make(),
                    subtitle: snapshot.data?[index].body.toString().text.make(),
                  );
                }));
          }),
    );
  }
}

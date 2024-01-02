import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            AwesomeNotifications().createNotification(
              content: NotificationContent(
                id: 1,
                channelKey: 'basic_channel',
                actionType: ActionType.Default,
                title: 'Eslam Sent a Message',
                body: 'Hello, Where are you now mother father!!',
              ),
            );
          },
          child: const Text("Show Notifications"),
        ),
      ),
    );
  }
}

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:localization_group_52/screens/login_screen.dart';
import 'package:localization_group_52/screens/notifications_screen.dart';
import 'package:localization_group_52/screens/proudcts_screen.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
      ],
      // Channel groups are only visual and are not required
      channelGroups: [
        NotificationChannelGroup(
            channelGroupKey: 'basic_channel_group',
            channelGroupName: 'Basic group')
      ],
      debug: true);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await EasyLocalization.ensureInitialized();

  String? token = await FirebaseMessaging.instance.getToken();
  print("token = $token");

  FirebaseMessaging.onMessage.listen((event) {
    // event.data
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: "basic_channel",
        title: event.notification == null
            ? event.data["title"]
            : event.notification!.title,
        body: event.notification == null
            ? event.data["body"]
            : event.notification!.body,
      ),
    );
  });

  FirebaseMessaging.onBackgroundMessage(_handler);

  runApp(
    EasyLocalization(
      startLocale: const Locale('en'),
      saveLocale: true,
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      path: 'assets/translations',
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      home: ProductsScreen(),
    );
  }
}

Future<void> _handler(RemoteMessage event) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      wakeUpScreen: true,
      criticalAlert: true,
      id: 1,
      channelKey: "basic_channel",
      title: event.notification == null
          ? event.data["title"]
          : event.notification!.title,
      body: event.notification == null
          ? event.data["body"]
          : event.notification!.body,
    ),
  );
}

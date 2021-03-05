import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repo_stars/bloc/app_model.dart';
import 'package:repo_stars/UI/home_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'UI/chart_screen.dart';
import 'UI/stars_screen.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');
InitializationSettings initializationSettings = InitializationSettings(
  android: initializationSettingsAndroid,
);
const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails('id', 'name', 'description',
        importance: Importance.max, priority: Priority.high, showWhen: true);
const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

void main() async {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GraphViewModel>(
          create: (_) => GraphViewModel(),
        ),
      ],
      builder: (context, child) {
        return MyApp();
      },
    ),
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: selectNotification);
}

Future selectNotification(String payload) async {
  navigatorKey.currentState.popUntil(ModalRoute.withName('/'));
  await navigatorKey.currentState.pushNamed('/chart_screen');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => HomeScreen(
              title: 'Repo Stars',
            ),
        '/chart_screen': (context) => ChartScreen(),
        '/stars_screen': (context) => StarsScreen(),
      },
      navigatorKey: navigatorKey,
      title: 'Repo Stars',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
    );
  }
}

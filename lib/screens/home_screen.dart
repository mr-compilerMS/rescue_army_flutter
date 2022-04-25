import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart';
import 'package:rescue_army/models/event.dart';
import 'package:rescue_army/screens/eventinfo_screen.dart';
import 'package:rescue_army/screens/events_screen.dart';
import 'package:rescue_army/screens/resources_screen.dart';
import 'package:rescue_army/screens/notification_screen.dart';
import 'package:rescue_army/utils/constants.dart';
import 'package:rescue_army/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';
import '../widgets/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  Future<void> setupInteractedMessage() async {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message);
      if (message.data['type'] == 'event') {
        final eid = message.data['id'];
        final event = await Event.fromAPI(eid);
        Navigator.of(context).pushNamed(AppRoutes.eventinfo, arguments: event);
      }
    });
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage == null) {
      return;
    }
    if (initialMessage.data['type'] == 'event') {
      final eid = initialMessage.data['id'];
      final event = await Event.fromAPI(eid);
      Navigator.of(context).pushNamed(AppRoutes.eventinfo, arguments: event);
    }
  }

  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // if (notification != null && android != null) {
      //   flutterLocalNotificationsPlugin.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     const NotificationDetails(
      //       android: AndroidNotificationDetails(
      //         'high_importance_channel',
      //         'High Importance Notifications',
      //         // icon: 'app_icon',
      //       ),
      //     ),
      //   );
      // }
    });
  }

  Widget _returnView() {
    switch (index) {
      case 0:
        return Home();
      case 1:
        return EventsScreen();
      case 2:
        return ResourcesScreen();
      case 3:
        return const NotificationScreen();
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _returnView(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => index = newIndex),
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Resources',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
        ],
      ),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final List<String> imglist = [
    'https://images.unsplash.com/photo-1478131143081-80f7f84ca84d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80',
    'https://images.unsplash.com/photo-1625621540023-d4940fa0a222?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1176&q=80',
    'https://images.unsplash.com/photo-1520352408661-83957c1379d2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1173&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white10,
        elevation: 0,
        title: "Rescue Army".text.color(context.accentColor).make(),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.person,
              color: context.accentColor,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Text(
            "Upcoming events",
            style: TextStyle(
              color: Colors.red[900],
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        CarouselSlider(
          items: imglist
              .map((item) => ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      item,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
          ),
        ),
      ]),
    );
  }
}

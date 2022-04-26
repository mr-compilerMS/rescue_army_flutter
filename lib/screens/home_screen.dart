import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:rescue_army/models/event.dart';

import 'package:rescue_army/screens/events_screen.dart';
import 'package:rescue_army/screens/resources_screen.dart';
import 'package:rescue_army/screens/notification_screen.dart';
import 'package:rescue_army/stores/app_store.dart';
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

  AppStore store = VxState.store;
  @override
  void initState() {
    super.initState();
    setupInteractedMessage();
    if (store.user == null) {
      SetUser();
    }

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
        return const EventsScreen();
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

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Event> eventlist = [];
  @override
  void initState() {
    super.initState();
    getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HomeDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: "Rescue Army".text.make(),
        iconTheme: const IconThemeData(color: Colors.black),
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.person,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.call,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.call),
          ),
        ],
      ),
      body: ListView(children: [
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Center(
            child: Text(
              "Latest events",
              style: TextStyle(
                color: Colors.red[900],
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ),
        CarouselSlider(
          items: eventlist
              .map((item) => ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.eventinfo,
                        arguments: item,
                      ),
                      child: Image.network(
                        item.image ?? "",
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            reverse: true,
          ),
        ),
        SizedBox(height: 20,),
        Title(
          color: Colors.red,
          child: Center(
            child: Text(
              "Latest Resources",
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
               
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        CarouselSlider(
          items: eventlist
              .map((item) => ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: InkWell(
                      onTap: () => Navigator.pushNamed(
                        context,
                        AppRoutes.eventinfo,
                        arguments: item,
                      ),
                      child: Image.network(
                        item.image ?? "",
                        fit: BoxFit.cover,
                        width: 1000,
                      ),
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

  void getEvents() {
    Event.fetchEvents().then((events) {
      setState(() {
        eventlist.clear();
        eventlist.addAll(events);
      });
    });
  }
}

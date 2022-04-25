import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rescue_army/firebase_options.dart';
import 'package:rescue_army/models/event.dart';
import 'package:rescue_army/screens/eventinfo_screen.dart';
import 'package:rescue_army/screens/home_screen.dart';
import 'package:rescue_army/screens/notification_screen.dart';
import 'package:rescue_army/screens/signin_screen.dart';
import 'package:rescue_army/screens/signup_screen.dart';
import 'package:rescue_army/utils/routes.dart';
import 'package:rescue_army/stores/app_store.dart';
import 'package:velocity_x/velocity_x.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  print(await FirebaseMessaging.instance.getToken());
  FirebaseMessaging.instance.subscribeToTopic('sangli');
  FirebaseMessaging.instance.subscribeToTopic('all');
  runApp(VxState(store: AppStore(), child: const App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AppRoutes.eventinfo
          : AppRoutes.eventinfo,
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.signin: (context) => const SigninScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.notification: (context) => const NotificationScreen(),
        AppRoutes.eventinfo: (context) =>  EventInfoScreen(),
              },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(),
      darkTheme: ThemeData.light(),
    );
  }
}

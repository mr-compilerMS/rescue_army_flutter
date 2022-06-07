import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rescue_army/firebase_options.dart';
import 'package:rescue_army/screens/call_screen.dart';
import 'package:rescue_army/screens/eventinfo_screen.dart';
import 'package:rescue_army/screens/events_screen.dart';
import 'package:rescue_army/screens/home_screen.dart';
import 'package:rescue_army/screens/new_user_screen.dart';
import 'package:rescue_army/screens/notification_screen.dart';
import 'package:rescue_army/screens/profile_page.dart';
import 'package:rescue_army/screens/signin_screen.dart';
import 'package:rescue_army/screens/signup_screen.dart';
import 'package:rescue_army/stores/app_store.dart';
import 'package:rescue_army/utils/routes.dart';
import 'package:velocity_x/velocity_x.dart';

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
  await FlutterDownloader.initialize(debug: false, ignoreSsl: false);
  await FlutterDownloader.registerCallback(callback);
  runApp(VxState(store: AppStore(), child: const App()));
}

late AndroidNotificationChannel channel;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // print('Handling a background message ${message.messageId}');
}

void callback(String id, DownloadTaskStatus status, int progress) {}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool loggedIn = false;
  isLoggedIn() async {
    final storage = new FlutterSecureStorage();
    final accessToken = await storage.read(key: "access");
    final refreshToken = await storage.read(key: "refresh");
    if (accessToken == null || refreshToken == null) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    isLoggedIn().then((value) {
      setState(() {
        loggedIn = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: !loggedIn ? AppRoutes.signin : AppRoutes.new_user,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.signin: (context) => const SigninScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
        AppRoutes.profile: (context) => const Profile(),
        AppRoutes.notification: (context) => const NotificationScreen(),
        AppRoutes.eventinfo: (context) => EventInfoScreen(),
        AppRoutes.call: (context) => CallScreen(),
        AppRoutes.events: (context) => EventsScreen(),
        AppRoutes.new_user: (context) => NewUserScreen(),
      },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: ThemeData(),
      darkTheme: ThemeData.light(),
    );
  }
}

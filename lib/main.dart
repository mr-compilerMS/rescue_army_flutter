import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rescue_army/firebase_options.dart';
import 'package:rescue_army/screens/home_screen.dart';
import 'package:rescue_army/screens/signin_screen.dart';
import 'package:rescue_army/screens/signup_screen.dart';
import 'package:rescue_army/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? AppRoutes.signin
          : AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => HomeScreen(),
        AppRoutes.signin: (context) => const SigninScreen(),
        AppRoutes.signup: (context) => const SignupScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
    );
  }
}

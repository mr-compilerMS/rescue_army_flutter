import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:http/http.dart';
import 'package:rescue_army/models/user.dart';
import 'package:rescue_army/services/auth/auth_provider.dart';
import 'package:rescue_army/stores/app_store.dart';
import 'package:rescue_army/utils/constants.dart';

class AppAuthProvider extends AuthProvider {
  @override
  Future<User?> get currentUser async => getCurrentUser();

  Future<User?> getCurrentUser() async {
    final fuser = FirebaseAuth.instance.currentUser;
    if (fuser == null) return null;
    final response =
        await get(Uri.parse(Constants.API_ENDPOINT + '/me'), headers: {
      'Authorization':
          "Token " + await FirebaseAuth.instance.currentUser!.getIdToken()
    });
    final user = User.fromJson(jsonDecode(response.body));
    print(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signIn(String phoneNumber, String password) async {
    post(Uri.parse(Constants.API_ENDPOINT + '/core/login/'),
        body: jsonEncode(<String, String>{
          "phone_number": "+91" + phoneNumber,
          "password": password
        })).then((response) {
      if (response.statusCode == 200) {
        String? token = jsonDecode(response.body)['token'];
        Map<String, dynamic>? user = jsonDecode(response.body)['user'];
        if (token != null) {
          AppStore().user = User.fromJson(user!);
          FirebaseAuth.instance
              .signInWithCustomToken(token)
              .then((value) async {})
              .onError((error, stackTrace) {});
        }
      } else if (response.statusCode == 400) {
        print(response.body);
      }
    });
  }
}

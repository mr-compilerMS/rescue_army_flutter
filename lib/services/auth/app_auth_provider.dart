import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:http/http.dart';
import 'package:rescue_army/models/user.dart';
import 'package:rescue_army/services/auth/auth_provider.dart';
import 'package:rescue_army/stores/app_store.dart';
import 'package:rescue_army/utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
  Future<bool> signIn(String phoneNumber, String password) async {
    final response =
        await post(Uri.parse(Constants.API_ENDPOINT + '/auth/jwt/create'),
            body: jsonEncode(
              <String, String>{
                "username": "+91" + phoneNumber,
                "password": password
              },
            ),
            headers: {
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      String? accessToken = jsonDecode(response.body)['access'];
      String? refreshToken = jsonDecode(response.body)['refresh'];
      final storage = new FlutterSecureStorage();
      await storage.write(key: "access", value: accessToken);
      await storage.write(key: "refresh", value: refreshToken);
      return true;
    } else if (response.statusCode == 401) {}

    return false;
  }
}

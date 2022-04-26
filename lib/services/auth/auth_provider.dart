import 'package:rescue_army/models/user.dart';

abstract class AuthProvider {
  Future<User?> get currentUser;
  Future signIn(String phoneNumber, String password);
  Future<void> signOut();
}

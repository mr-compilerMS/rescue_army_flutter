import 'package:flutter/material.dart';
import 'package:rescue_army/models/user.dart';

@immutable
class AuthUser {
  final User user;
  final String token;

  const AuthUser(this.user, this.token);

  factory AuthUser.fromJson(Map<String, dynamic> data) {
    return AuthUser(User.fromJson(data), data['token']);
  }
}

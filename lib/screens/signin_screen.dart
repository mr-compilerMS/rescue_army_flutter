// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rescue_army/utils/constants.dart';
import 'package:rescue_army/utils/routes.dart';
import 'package:http/http.dart' as http;

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String phoneNumber = "";
  String password = "";

  _signIn(BuildContext context) async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    try {
      http
          .post(Uri.parse(Constants.API_ENDPOINT + '/core/login/'),
              body: jsonEncode(<String, String>{
                "phone_number": "+91" + phoneNumber,
                "password": password
              }))
          .then((response) {
        String? token = jsonDecode(response.body)['token'];
        print(response.body);
        if (token != null) {
          print(token);
          FirebaseAuth.instance
              .signInWithCustomToken(token)
              .then((value) async {})
              .onError((error, stackTrace) {});
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null) {
        Navigator.popAndPushNamed(context, AppRoutes.home);
        // FirebaseAuth.instance.signOut();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "assets/images/ndrf.png",
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome $phoneNumber",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "",
                              labelText: "Mobile No",
                              prefix: Text("+91")),
                          onChanged: (value) {
                            phoneNumber = value;
                            setState(() {});
                          },
                          textInputAction: TextInputAction.next,
                        ),
                        TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: "Enter Password",
                            labelText: "Password",
                          ),
                          onChanged: (value) {
                            password = value;
                            setState(() {});
                          },
                          textInputAction: TextInputAction.done,
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        InkWell(
                          onTap: () => _signIn(context),
                          child: Container(
                              width: 150,
                              height: 50,
                              // color: Colors.deepPurple,
                              alignment: Alignment.center,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.deepPurple,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          child: Text("Forget Password ?"),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.home);
                          },
                        ),
                        Text("Or"),
                        TextButton(
                          child: Text("Sign Up"),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.signup);
                          },
                        )

                        // ElevatedButton(
                        //   child: Text("Login"),
                        //   style: TextButton.styleFrom(
                        //     minimumSize: Size(150, 40)),
                        //   onPressed: () {
                        //     Navigator.pushNamed(context, MyRoutes.homeRoute);
                        //   },
                        // )
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}

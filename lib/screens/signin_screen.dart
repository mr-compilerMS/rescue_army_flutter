// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rescue_army/services/auth/app_auth_provider.dart';
import '../stores/app_store.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';
import 'package:http/http.dart' as http;

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String phoneNumber = "";
  String password = "";
  final _formKey = GlobalKey<FormState>();

  _signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      try {
        AppAuthProvider().signIn(phoneNumber, password);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.userChanges().listen((event) {
      if (event != null) {
        Navigator.popAndPushNamed(context, AppRoutes.home);
        SetUser();
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
            child: Form(
              key: _formKey,
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
                    "Welcome",
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              phoneNumber = value;
                              setState(() {});
                            },
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            textInputAction: TextInputAction.next,
                          ),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: "Enter OTP",
                              labelText: "OTP",
                            ),
                            validator: (value) {
                              // if (value!.isEmpty) {
                              //   return 'Please enter your OTP';
                              // }
                              // else if(value.length != 6){
                              //   return 'Please should be atleast 6 digits';
                              // }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                              setState(() {});
                            },
                            keyboardType: TextInputType.number,
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
                          // TextButton(
                          //   child: Text("Forget Password ?"),
                          //   onPressed: () {
                          //     Navigator.pushNamed(context, AppRoutes.forget);
                          //   },
                          // ),
                          // Text("Or"),
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
          ),
        ));
  }
}

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:rescue_army/utils/routes.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String name = "";

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
                  "Welcome $name",
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
                            hintText: "Enter Mobile No",
                            labelText: "Mobile No",
                          ),
                          onChanged: (value) {
                            name = value;
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
                          textInputAction: TextInputAction.done,
                        ),

                        SizedBox(
                          height: 40,
                        ),

                        InkWell(
                          onTap: () => Navigator.popAndPushNamed(
                              context, AppRoutes.home),
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

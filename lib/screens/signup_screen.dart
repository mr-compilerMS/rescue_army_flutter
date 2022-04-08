import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import 'package:velocity_x/velocity_x.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isSignIn = false;
  bool _isPhoneSubmit = false;
  String _phone = '';
  String _otp = '';

  onSignIn() {
    setState(() {
      _isSignIn = true;
    });
  }

  _requestOtpSubmit(phone) {
    _phone = phone;
    setState(() {
      _isPhoneSubmit = true;
    });
  }

  _checkOtp(otp) {
    _otp = otp;
    setState(() {
      _isSignIn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.screenWidth * 0.07),
          child: !_isSignIn
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user,
                      color: Colors.blue,
                      size: context.screenWidth / 4,
                    ),
                    16.heightBox,
                    "Enter Your Phone Number".text.make().scale150(),
                    24.heightBox,
                    SizedBox(
                      height: context.screenHeight / 5,
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 800),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return SizeTransition(
                            sizeFactor: animation,
                            child: child,
                          );
                        },
                        child: !_isPhoneSubmit
                            ? _phoneInputWidget(context)
                            : _smsCodeInputWidget(context),
                      ),
                    )
                  ],
                )
              : const Center(
                  child: Text('hello'),
                ),
        ),
      ),
    );
  }

  _phoneInputWidget(BuildContext context) {
    return SizedBox(
      key: ValueKey<int>(0),
      height: context.screenHeight / 5,
      child: PhoneInput(
        initialCountryCode: "IN",
        onSubmit: _requestOtpSubmit,
      ),
    );
  }

  _smsCodeInputWidget(BuildContext context) {
    return SizedBox(
      key: ValueKey<int>(1),
      height: context.screenHeight / 5,
      child: SMSCodeInput(
        autofocus: false,
        onSubmit: _checkOtp,
      ),
    );
  }
}

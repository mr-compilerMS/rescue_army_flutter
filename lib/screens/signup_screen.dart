import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:rescue_army/utils/routes.dart';

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
  String? _verificationId = null;
  onSignIn() {
    Navigator.popAndPushNamed(context, AppRoutes.new_user, arguments: _phone);
  }

  _requestOtpSubmit(phone) async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {
        FirebaseAuth.instance
            .signInWithCredential(credential)
            .then((value) => onSignIn());
      },
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        Navigator.of(context).pop();
        setState(() {
          _verificationId = verificationId;
          _isPhoneSubmit = true;
          _phone = phone;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  _checkOtp(otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!, smsCode: otp);
    FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) => onSignIn());
  }

  @override
  Widget build(BuildContext context) {
    // return RegisterScreen(
    //   providerConfigs: [PhoneProviderConfiguration()],
    //   showAuthActionSwitch: false,

    // );
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
              : navigateToProfile_page(),
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

  navigateToProfile_page() {}
}

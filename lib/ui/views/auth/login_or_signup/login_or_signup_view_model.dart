import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/ui/views/auth/login/login_view.dart';
import '../sign_up/signup_view.dart';
import 'package:stacked/stacked.dart';

class LoginOrSignUPViewModel extends BaseViewModel {


  void gotoLogin(BuildContext context) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=> const LoginView()));
  }

  void gotoSignUP(BuildContext context) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=> const SignUpView()));
    }
}
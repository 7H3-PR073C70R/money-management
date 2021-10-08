import 'package:flutter/material.dart';
import '../sign_up/signup_view.dart';
import 'package:stacked/stacked.dart';

class LoginOrSignUPViewModel extends BaseViewModel {


  void gotoLogin(BuildContext context) {
    
  }

  void gotoSignUP(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const SignUpView()));
    }
}
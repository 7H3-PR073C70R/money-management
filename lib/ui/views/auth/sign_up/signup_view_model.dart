import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/ui/views/auth/login/login_view.dart';
import '../email_verification/email_verification_view.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  bool _isPasswordVisible = true;

  bool get passwordVisibility => _isPasswordVisible;

  void setPasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void gotoConfirmPassword(BuildContext context) {
    Navigator.of(context).pushReplacement(
        CupertinoPageRoute(builder: (context) => const EmailVarificationView()));
  }

  void gotoLogin(context) {
    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=> const LoginView()));
  }
}

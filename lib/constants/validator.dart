import 'package:flutter/material.dart';

/// This extension is for form validations using the [FormKey] approach
/// Import this file in any form view and call the methods from the [Buildcontext]'s
/// [context] variable
///
/// This extension still needs improvement
extension ValidationExtension on BuildContext {
  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) return 'Field cannot be empty';

    bool isEmailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email.trim());

    return (isEmailValid) ? null : 'Please enter a valid email';
  }

  String? validatePassword(String? password, [bool isNotLogin = true]) {
    if (password == null || password.isEmpty) return 'Field cannot be empty';

    if (isNotLogin) {
      bool isPasswordValid = (password.length >= 8 &&
          RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$")
              .hasMatch(password));

      return (isPasswordValid)
          ? null
          : 'Password must be at least 8 characters long and must contain at least one uppercase, one lowercase and a character';
    }
  }

  String? validateConfirmPassword(String password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Field cannot be empty';
    }

    bool isValid = password.compareTo(confirmPassword) >= 0;

    return (isValid) ? null : 'The passwords does not match';
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) return 'Field cannot be empty';

    bool isNameValid = name.length >= 3;

    return (isNameValid) ? null : 'Please enter a valid name';
  }
}

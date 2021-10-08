import 'package:flutter/material.dart';
import 'login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container()
      ),
      viewModelBuilder: () => LoginViewModel(),
      onDispose: (model) {},
    );
  }
}

import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'login_or_signup_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginOrSignUpView extends StatelessWidget {
  const LoginOrSignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return ViewModelBuilder<LoginOrSignUPViewModel>.nonReactive(
      builder: (context, model, child) => StatusBar(
        color: kcPrimaryColor,
        child: Scaffold(
            body: Stack(
          children: [
            Image.asset(splashImage, height: _size.height, width: _size.width, fit: BoxFit.fill,),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 35, right: 35, bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  BoxButton(
                    title: loginOrSignupLoginText,
                    isLogin: true,
                    onTap: model.gotoLogin,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  BoxButton(
                    title: loginOrSignupSignupText,
                    isSignUp: true,
                    onTap: model.gotoSignUP
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ]),
              ),
            ),
          ],
        )),
      ),
      viewModelBuilder: () => LoginOrSignUPViewModel(),
    );
  }
}

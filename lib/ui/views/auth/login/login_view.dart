import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/rich_text.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:money_management/ui/views/auth/forget_password/forget_password_view.dart';
import 'package:money_management/ui/views/auth/sign_up/signup_view.dart';
import 'package:money_management/ui/views/main/main_view.dart';
import 'login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = screenHeiht(context);
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => StatusBar(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37),
                child: SingleChildScrollView(
                  child: SizedBox(
                    height: height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(logInPng),
                        verticalSpaceSmall,
                        const RichTexts(welcomeText, backText),
                        verticalSpaceSmall,
                        Text(
                          fillDetailText,
                          style: heading6Style.copyWith(color: kcNeutral3),
                        ),
                        verticalSpaceExtraLarge,
                        const BoxInputField(placeHolder: emailPlaceHolderText),
                        verticalSpaceMedium,
                        BoxInputField(
                          placeHolder: passwordPlaceHolder,
                          isPassword: true,
                          onVisibilityPressed: model.setIsPasswordVisible,
                          passwordVisibility: model.isPasswordVisible,
                        ),
                        verticalSpaceVeryTiny,
                        SizedBox(
                          width: double.infinity,
                          child: GestureDetector(
                            onTap: model.navigateToForgetPassword,
                            child: Text(
                              forgetPasswordText,
                              textAlign: TextAlign.right,
                              style: bodyStyle.copyWith(
                                color: kcBlue1,
                              ),
                            ),
                          ),
                        ),
                        verticalSpaceSmall,
                        BoxButton(
                            title: loginOrSignupLoginText,
                            onTap: model.navigateToMainView),
                        verticalSpaceSmall,
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: dontHaveAnAcctText,
                                    style: bodyStyle.copyWith(
                                        color: Colors.black),
                                    children: [
                                      TextSpan(
                                          text: loginOrSignupSignupText,
                                          style: bodyStyle.copyWith(
                                            color: kcBlue1,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = model.navigateToSignUpView)
                                    ])),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
      viewModelBuilder: () => LoginViewModel(),
      onDispose: (model) {},
    );
  }
}

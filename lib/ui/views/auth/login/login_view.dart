import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_management/ui/shared/dumb_widgets/auth_icon_button.dart';
import '../../../../constants/validator.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/const_color_helper.dart';
import '../../../shared/const_ui_helper.dart';
import '../../../shared/dumb_widgets/rich_text.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      builder: (context, model, child) => StatusBar(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 32),
                child: Center(
                  child: SingleChildScrollView(
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
                       
                        if (model.hasError)
                          Column(
                            children: [
                              verticalSpaceSmall,
                              Text(
                                model.modelError.toString().contains('network')
                                    ? networkErrorText
                                    : invalidCredentialText,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: bodyStyle.copyWith(
                                    color: Theme.of(context).errorColor),
                              ),
                            ],
                          ),
                        verticalSpaceSmall,
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              BoxInputField(
                                placeHolder: emailPlaceHolderText,
                                onChanged: model.setEmail,
                                validator: context.validateEmail,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              verticalSpaceMedium,
                              BoxInputField(
                                placeHolder: passwordPlaceHolder,
                                isPassword: true,
                                onChanged: model.setPassword,
                                onVisibilityPressed: model.setIsPasswordVisible,
                                passwordVisibility: model.isPasswordVisible,
                                validator: (text) =>
                                    context.validatePassword(text, false),
                              ),
                            ],
                          ),
                        ),
                        verticalSpaceVeryTiny,
                        SizedBox(
                          width: double.infinity,
                          child: InkWell(
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
                            isBusy: model.isBusy,
                            title: loginOrSignupLoginText,
                            onTap: () {
                              if (!_formKey.currentState!.validate()) {
                                return;
                              }
                              model.login();
                            }),
                        verticalSpaceSmall,
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                    text: dontHaveAnAcctText,
                                    style:
                                        bodyStyle.copyWith(color: Colors.black),
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
    );
  }
}

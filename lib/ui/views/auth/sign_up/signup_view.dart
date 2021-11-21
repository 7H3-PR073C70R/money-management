import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../constants/validator.dart';
import '../../../../model/user_model.dart';
import '../../../shared/dumb_widgets/auth_icon_button.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/dumb_widgets/rich_text.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'signup_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);

    final _emailController = TextEditingController();
    final _fNameController = TextEditingController();
    final _lNameController = TextEditingController();
    final _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      onDispose: (model) {
        _emailController.dispose();
        _fNameController.dispose();
        _lNameController.dispose();
        _passwordController.dispose();
      },
      builder: (context, model, child) => StatusBar(
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0),
                      child: Center(
                        child: SvgPicture.asset(signUpSvg),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const RichTexts(createText, personalAccounText),
                    const SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 38),
                          child: Form(
                            key: _formKey,
                              child: Column(
                            children: [
                              BoxInputField(
                                  controller: _fNameController,
                                  validator: context.validateName,
                                  placeHolder: firstNamePlaceHolder),
                              const SizedBox(
                                height: 16,
                              ),
                              BoxInputField(
                                  controller: _lNameController,
                                  validator: context.validateName,
                                  placeHolder: lastNamePlaceHolder),
                              const SizedBox(
                                height: 16,
                              ),
                              BoxInputField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: context.validateEmail,
                                  placeHolder: emailPlaceHolderText),
                              const SizedBox(
                                height: 16,
                              ),
                              BoxInputField(
                                controller: _passwordController,
                                placeHolder: passwordPlaceHolder,
                                isPassword: true,
                                passwordVisibility: model.passwordVisibility,
                                validator: context.validatePassword,
                                onVisibilityPressed: model.setPasswordVisibility,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              BoxInputField(
                                placeHolder: confirmPasswordPlaceHolder,
                                isPassword: true,
                                passwordVisibility: model.passwordVisibility,
                                validator: (text) => context.validateConfirmPassword(_passwordController.text, text),
                                onVisibilityPressed: model.setPasswordVisibility,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          )),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 27),
                          child: BoxButton(
                            title: createAccountText,
                            isBusy: model.isBusy,
                            onTap: () {
                              if(!_formKey.currentState!.validate()){
                                return;
                              }
                              model.signUp(
                                  user: User(
                                      email: _emailController.text.trim(),
                                      lname: _lNameController.text,
                                      fname: _fNameController.text),
                                  password: _passwordController.text);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Center(child: BoxText.body(orSignUpWithText)),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          width: 256,
                          child: Column(
                            children: [
                              BuildAuthButtomIcon(svgImagePath: googleSvg, onTap: model.signUpWithGoogle),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Row(
                                  children: [
                                    BoxText.body(
                                      alreadyHaveanAccountText,
                                      color: kcMiniGray,
                                    ),
                                    InkWell(
                                        onTap: model.gotoLogin,
                                        child: BoxText.body(
                                          loginOrSignupLoginText,
                                          color: kcPrimaryColor,
                                        ))
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}


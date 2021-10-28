import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/dumb_widgets/rich_text.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'signup_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      builder: (context, model, child) => StatusBar(
        child: Scaffold(
          body: SingleChildScrollView(
            child: SafeArea(
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
                            child: Column(
                          children: [
                            BoxInputField(placeHolder: firstNamePlaceHolder),
                            const SizedBox(
                              height: 16,
                            ),
                            BoxInputField(placeHolder: lastNamePlaceHolder),
                            const SizedBox(
                              height: 16,
                            ),
                            BoxInputField(placeHolder: emailPlaceHolderText),
                            const SizedBox(
                              height: 16,
                            ),
                            BoxInputField(placeHolder: passwordPlaceHolder, isPassword: true, passwordVisibility: model.passwordVisibility, onVisibility: model.setPasswordVisibility,),
                            const SizedBox(
                              height: 16,
                            ),
                            BoxInputField(placeHolder: confirmPasswordPlaceHolder, isPassword: true, passwordVisibility: model.passwordVisibility, onVisibility: model.setPasswordVisibility,),
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
                        child: BoxButton(title: createAccountText, onTap: (){model.gotoConfirmPassword(context);},),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                BuildButtomIcon(svgImagePath: googleSvg),
                                BuildButtomIcon(svgImagePath: facebookSvg),
                                BuildButtomIcon(svgImagePath: twitterSvg),
                              ],
                            ),
                            
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12.0),
                              child: Row(
                                children: [
                                  BoxText.body(alreadyHaveanAccountText, color: kcMiniGray,),
                                  GestureDetector(
                                    onTap: () => model.gotoLogin(context),
                                    child: BoxText.body(loginOrSignupLoginText, color: kcPrimaryColor,)
                                  )
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
      viewModelBuilder: () => SignUpViewModel(),
    );
  }
}

class BuildButtomIcon extends StatelessWidget {
  final String svgImagePath;
  final VoidCallback? onTap;
  const BuildButtomIcon({ Key? key, required this.svgImagePath, this.onTap }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
          backgroundColor: kcMiniGray,
          child: Center(child: SvgPicture.asset(svgImagePath))),
    );
  }
}
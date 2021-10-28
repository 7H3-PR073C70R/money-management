import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:money_management/ui/views/auth/login/login_view.dart';
import 'package:stacked/stacked.dart';
import 'verified_view_model.dart';

class VerifiedView extends StatelessWidget {
  const VerifiedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifiedViewModel>.reactive(
      viewModelBuilder: () => VerifiedViewModel(),
      builder: (
        BuildContext context,
        VerifiedViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(verifiedPng),
                verticalSpaceLarge,
                BoxText.headingSix(verifiedText),
                verticalSpaceLarge,
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: screenWidth(context) * 0.1),
                  child: BoxButton(title: loginOrSignupLoginText, onTap: () => Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const LoginView())),),
                )
              ],
            )
          ),
        );
      },
    );
  }
}
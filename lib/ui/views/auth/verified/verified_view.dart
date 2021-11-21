import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/const_ui_helper.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
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
                  child: BoxButton(title: loginOrSignupLoginText, onTap: model.gotoLogin,),
                )
              ],
            )
          ),
        );
      },
    );
  }
}
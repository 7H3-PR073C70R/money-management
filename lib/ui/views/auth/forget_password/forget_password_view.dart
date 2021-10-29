import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:stacked/stacked.dart';

import 'forget_password_view_model.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgetPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgetPasswordViewModel(),
      builder: (
        BuildContext context,
        ForgetPasswordViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(resetPasswordText, style: heading6Style.copyWith(color: kcBlue1),),
                  verticalSpaceSmall,
                  Text(getResetLinkText, style: heading6Style.copyWith(fontSize: 16), textAlign: TextAlign.center,),
                  verticalSpaceLarge,
                  BoxInputField(placeHolder: emailPlaceHolderText),
                  verticalSpaceMedium,
                  BoxButton(title: resetPasswordButtonText, onTap: (){},)
                ],
              ),
            )
          ),
        );
      },
    );
  }
}
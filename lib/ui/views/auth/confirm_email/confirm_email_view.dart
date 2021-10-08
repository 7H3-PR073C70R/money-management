import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:stacked/stacked.dart';
import 'confirm_email_view_model.dart';

class ConfirmEmailView extends StatelessWidget {
  const ConfirmEmailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ConfirmEmailViewModel>.nonReactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(emailSentImage)),
              const SizedBox(
                height: 64,
              ),
              BoxText.headingSix(checkEmailText),
              const SizedBox(
                height: 18,
              ),
              BoxText.body(confirmEmailMessageText),
              RichText(
                text: TextSpan(
                    text: pleaseCheckText,
                    style: bodyStyle.copyWith(color: kcMaxGray),
                    children: [
                      TextSpan(
                          text: emailPlaceHolderText,
                          style: bodyStyle.copyWith(color: kcPrimaryColor)),
                      TextSpan(
                          text: forLinkText,
                          style: bodyStyle.copyWith(color: kcMaxGray))
                    ]),
              ),
              const SizedBox(
                height: 36,
              ),
              GestureDetector(
                child: RichText(
                  text: TextSpan(
                      text: dontRecieveCodeText,
                      style: bodyStyle.copyWith(color: kcMaxGray),
                      children: [
                        TextSpan(
                            text: ' $resendText',
                            style: bodyStyle.copyWith(color: kcPrimaryColor)),
                      ]),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: BoxButton(title: loginText),
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => ConfirmEmailViewModel(),
    );
  }
}

import 'package:box_ui/box_ui.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:money_management/app/app.router.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import '../../../../constants/app_image_path.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'package:stacked/stacked.dart';
import 'confirm_email_view_model.dart';

class ConfirmEmailView extends StatelessWidget {
  final String email;
  final bool? isConfirmEmail;
  const ConfirmEmailView({Key? key, required this.email, this.isConfirmEmail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ConfirmEmailViewArguments;
    final bool isConfirmEmail = args.isConfirmEmail ?? true;
    return ViewModelBuilder<ConfirmEmailViewModel>.nonReactive(
      builder: (context, model, child) => StatusBar(
        child: Scaffold(
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Stack(
              children: [
                Column(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: RichText(
                        text: TextSpan(
                            text: isConfirmEmail
                                ? confirmEmailMessageText
                                : resetLinkSent,
                            style: bodyStyle.copyWith(color: kcMaxGray),
                            children: [
                              TextSpan(
                                  text: pleaseCheckText,
                                  style: bodyStyle.copyWith(color: kcMaxGray)),
                              TextSpan(
                                  text: ' $email',
                                  style: bodyStyle.copyWith(
                                      color: kcPrimaryColor)),
                              TextSpan(
                                  text: forLinkText,
                                  style: bodyStyle.copyWith(color: kcMaxGray))
                            ]),
                      ),
                    ),
                    verticalSpaceSmall,
                    GestureDetector(
                      child: RichText(
                        text: TextSpan(
                            text: dontRecieveCodeText,
                            style: bodyStyle.copyWith(color: kcMaxGray),
                            children: [
                              TextSpan(
                                  text: ' $resendText',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => model.sendVerificationCode(
                                        isConfirmEmail, email),
                                  style: bodyStyle.copyWith(
                                      color: kcPrimaryColor)),
                            ]),
                      ),
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BoxButton(
                        title: loginText,
                        onTap: model.gotoLogin,
                      ),
                    ),
                  ],
                ),
                if (model.isBusy)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => ConfirmEmailViewModel(),
    );
  }
}

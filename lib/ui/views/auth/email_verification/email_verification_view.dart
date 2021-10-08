import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:stacked/stacked.dart';
import 'email_varification_view_model.dart';

class EmailVarificationView extends StatelessWidget {
  const EmailVarificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EmailVarificationViewModel>.reactive(
      viewModelBuilder: () => EmailVarificationViewModel(),
      builder: (
        BuildContext context,
        EmailVarificationViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          backgroundColor: Colors.white,
            body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                  SvgPicture.asset(emailVerifySvg),
                  Center(
                    child: SvgPicture.asset(emailVerifySvg2),
                  )
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            Text.rich(TextSpan(
                  text: emailText,
                  style: heading5Style.copyWith(color: Colors.green),
                  children: [
                    TextSpan(
                        text: verificationText,
                        style: heading5Style.copyWith(color: Colors.black))
                  ])),
            const SizedBox(
              height: 16,
            ),
            Container(
              color: const Color.fromRGBO(234, 241, 251, 1),
              height: 87,
              width: 305,
              child:  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 35),
                    child: Text(
                      weSentVerificationText,
                      style: bodyStyle.copyWith(color: const Color.fromRGBO(47, 115, 218, 1)),
                    )),
            ),
            const SizedBox(
              height: 40,
            ),
                  OTPTextField(
              length: 5,
              width: MediaQuery.of(context).size.width,
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldWidth: 55,
              fieldStyle: FieldStyle.box,
              outlineBorderRadius: 15,
              style: const TextStyle(fontSize: 17),
              onChanged: (pin) {
              },
              onCompleted: (pin) {
              },
            ),
            const SizedBox(height: 16,),
            const Padding(
              padding:  EdgeInsets.symmetric(horizontal: 35),
              child:  BoxButton(title: verifyText),
            ),
            const SizedBox(height: 16,),
            GestureDetector(
              child: BoxText.body(cancelText, color: const Color.fromRGBO(234, 82, 48, 1),),
            )
          ],
        ),
                )));
      },
    );
  }
}

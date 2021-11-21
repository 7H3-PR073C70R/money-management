import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import '../../../../constants/validator.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/const_color_helper.dart';
import '../../../shared/const_ui_helper.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'package:stacked/stacked.dart';

import 'forget_password_view_model.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({Key? key}) : super(key: key);
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ForgetPasswordViewModel>.reactive(
      viewModelBuilder: () => ForgetPasswordViewModel(),
      onDispose: (model) {
        _emailController.dispose();
        focusNode.dispose();
      },
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
                    Text(
                      resetPasswordText,
                      style: heading6Style.copyWith(color: kcBlue1),
                    ),
                    verticalSpaceSmall,
                    Text(
                      getResetLinkText,
                      style: heading6Style.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceMedium,
                    if (model.hasError)
                      Text(
                        model.modelError.toString().contains('network')
                            ? networkErrorText
                            : invalidCredentialText,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: bodyStyle.copyWith(
                            color: Theme.of(context).errorColor),
                      ),
                    verticalSpaceSmall,
                    Form(
                      key: _formKey,
                      child: BoxInputField(
                        placeHolder: emailPlaceHolderText,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: context.validateEmail,
                      ),
                    ),
                    verticalSpaceMedium,
                    BoxButton(
                      title: resetPasswordButtonText,
                      isBusy: model.isBusy,
                      onTap: () {
                        focusNode.unfocus();
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        model.sendResetPasswordLink(_emailController.text);
                      },
                    ),
                    verticalSpaceSmall,
                    TextButton(onPressed: model.gotoBack, child: Text('Go Back', style: heading6Style.copyWith(color: kcPrimaryColor),))
                  ],
                ),
              )),
        );
      },
    );
  }
}

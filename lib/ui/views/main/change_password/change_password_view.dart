import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/const_ui_helper.dart';
import 'package:stacked/stacked.dart';
import 'change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(),
      builder: (
        BuildContext context,
        ChangePasswordViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            title: Text(
              changePasswordText,
              style: heading6Style.copyWith(
                color: kcPrimaryColor,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpaceSmall,
                  Form(
                        child: Column(
                      children: [
                        BoxInputField(
                          label: currentPasswordLabel,
                          isPassword: true,
                          maxLines: 1,
                          passwordVisibility: model.passwordVisibility,
                          onVisibilityPressed: model.setPasswordVisibility
                        ),
                        verticalSpaceSmall,
                        BoxInputField(
                          label: newPasswordLabel,
                          isPassword: true,
                          maxLines: 1,
                          passwordVisibility: model.currentPasswordVisibility,
                          onVisibilityPressed: model.setCurrentPasswordVisibility,
                        ),
                        verticalSpaceSmall,
                        BoxInputField(
                          label: confirmPasswordLabel,
                          isPassword: true,
                          maxLines: 1,
                          passwordVisibility: model.confirmPasswordVisibility,
                           onVisibilityPressed: model.setConfirmPasswordVisibility,
                        ),
                      ],
                    )),
                    verticalSpaceMedium,
                    BoxButton(
                      title: saveText,
                      onTap: () {},
                    )
                ],
              ),
            ),
          )
        );
      },
    );
  }
}
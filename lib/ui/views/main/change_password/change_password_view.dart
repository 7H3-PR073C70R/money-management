import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import '../../../../constants/validator.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/const_ui_helper.dart';
import 'package:stacked/stacked.dart';
import 'change_password_view_model.dart';

class ChangePasswordView extends StatelessWidget {
  ChangePasswordView({Key? key}) : super(key: key);

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(),
      onDispose: (model) {
        _oldPasswordController.dispose();
        _newPasswordController.dispose();
        _confirmPasswordController.dispose();
      },
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
                        key: _formKey,
                        child: Column(
                          children: [
                            BoxInputField(
                              label: currentPasswordLabel,
                              isPassword: true,
                              maxLines: 1,
                              passwordVisibility: model.passwordVisibility,
                              onVisibilityPressed: model.setPasswordVisibility,
                              controller: _oldPasswordController,
                              validator: context.validateName,
                            ),
                            verticalSpaceSmall,
                            BoxInputField(
                              label: newPasswordLabel,
                              isPassword: true,
                              maxLines: 1,
                              passwordVisibility:
                                  model.currentPasswordVisibility,
                              onVisibilityPressed:
                                  model.setCurrentPasswordVisibility,
                              controller: _newPasswordController,
                              validator: context.validatePassword,
                            ),
                            verticalSpaceSmall,
                            BoxInputField(
                              label: confirmPasswordLabel,
                              isPassword: true,
                              maxLines: 1,
                              passwordVisibility:
                                  model.confirmPasswordVisibility,
                              onVisibilityPressed:
                                  model.setConfirmPasswordVisibility,
                              validator: (value) =>
                                  context.validateConfirmPassword(
                                      _newPasswordController.text, value),
                            ),
                          ],
                        )),
                    verticalSpaceMedium,
                    BoxButton(
                      title: saveText,
                      onTap: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        model.updateUserPassword(
                            oldPassword: _oldPasswordController.text,
                            newPassword: _newPasswordController.text);
                      },
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }
}

import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../constants/app_image_path.dart';
import '../../../constants/app_string.dart';
import '../../shared/const_color_helper.dart';
import '../../shared/const_ui_helper.dart';
import '../../shared/dumb_widgets/setting_menu_item.dart';
import 'package:stacked/stacked.dart';
import 'profile_settings_view_model.dart';

class ProfileSettingsView extends StatelessWidget {
  ProfileSettingsView({Key? key}) : super(key: key);

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileSettingsViewModel>.reactive(
      viewModelBuilder: () => ProfileSettingsViewModel(),
      onDispose: (model) {
        _fnameController.dispose();
        _lnameController.dispose();
        _emailController.dispose();
      },
      builder: (
        BuildContext context,
        ProfileSettingsViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            appBar: AppBar(
              toolbarHeight: 60,
              leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              title: Text(
                profileText,
                style: heading6Style.copyWith(
                  color: kcPrimaryColor,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: screenHeiht(context) - 66,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceSmall,
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: kcNeutral7,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(70),
                                  child: model.imagePath == null
                                      ? Image.network(
                                          model.user.profileUrl ?? defaultImageurl,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.file(
                                          model.imagePath!,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                            Positioned(
                              left: 35,
                              top: 35,
                              child: IconButton(
                                onPressed: model.pickImage,
                                icon: const CircleAvatar(
                                    radius: 30,
                                    backgroundColor: kcPrimaryColor,
                                    child: Icon(Icons.photo_camera_outlined)),
                              ),
                            )
                          ],
                        ),
                      ),
                      verticalSpaceMedium,
                      Form(
                          child: Column(
                        children: [
                          BoxInputField(
                            label: firstNameLabel,
                            placeHolder: '${model.user.fname}',
                            controller: _fnameController,
                          ),
                          verticalSpaceSmall,
                          BoxInputField(
                            label: lastNameLabel,
                            placeHolder: '${model.user.lname}',
                            controller: _lnameController,
                          ),
                          verticalSpaceSmall,
                          BoxInputField(
                            label: emailLabel,
                            placeHolder: '${model.user.email}',
                            controller: _emailController,
                          ),
                        ],
                      )),
                      verticalSpaceSmall,
                      SettingsMenuItem(
                          imgPath: lockIcon,
                          text: changePasswordText,
                          onTap: model.gotoChangePasswordView),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: BoxButton(
                          title: saveText,
                          isBusy: model.isBusy,
                          onTap: () =>
                            model.updateUserData(
                              fname: _fnameController.text,
                              lname: _lnameController.text,
                              email: _emailController.text,
                            )
                          
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}

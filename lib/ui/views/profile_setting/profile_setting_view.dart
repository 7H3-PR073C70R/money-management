import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/setting_menu_item.dart';
import 'package:money_management/ui/views/main/change_password/change_password_view.dart';
import 'package:stacked/stacked.dart';
import 'profile_settings_view_model.dart';

class ProfileSettingsView extends StatelessWidget {
  const ProfileSettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileSettingsViewModel>.reactive(
      viewModelBuilder: () => ProfileSettingsViewModel(),
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
                height: screenHeiht(context) -  66,
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
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: kcNeutral7,
                              child: SvgPicture.asset(defaultDPSvg),
                            ),
                            Positioned(
                              left: 35,
                              top: 35,
                              child: IconButton(
                                onPressed: () {},
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
                        children: const [
                          BoxInputField(
                            label: firstNameLabel,
                            placeHolder: 'Toxic',
                          ),
                          verticalSpaceSmall,
                          BoxInputField(
                            label: lastNameLabel,
                            placeHolder: 'Bishop',
                          ),
                          verticalSpaceSmall,
                          BoxInputField(
                            label: firstNameLabel,
                            placeHolder: 'toxicbishop@gmail.com',
                          ),
                        ],
                      )),
                      verticalSpaceSmall,
                      SettingsMenuItem(
                          imgPath: lockIcon,
                          text: changePasswordText,
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(builder: (_) => const ChangePasswordView()));
                          }),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 35),
                        child: BoxButton(
                          title: saveText,
                          onTap: () {},
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

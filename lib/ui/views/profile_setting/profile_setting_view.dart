import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants/app_image_path.dart';
import '../../../constants/app_string.dart';
import '../../shared/const_color_helper.dart';
import '../../shared/const_ui_helper.dart';
import '../../shared/dumb_widgets/setting_menu_item.dart';
import '../main/change_password/change_password_view.dart';
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
                                      ? SvgPicture.asset(
                                          defaultDPSvg,
                                          fit: BoxFit.scaleDown,
                                        )
                                      : Image.file(
                                          model.imagePath!,
                                          fit: BoxFit.fill,
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
                            Navigator.of(context).push(CupertinoPageRoute(
                                builder: (_) => const ChangePasswordView()));
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

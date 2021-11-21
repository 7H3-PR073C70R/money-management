import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../../../constants/app_image_path.dart';
import '../../../../../constants/app_string.dart';
import '../../../../shared/const_ui_helper.dart';
import '../../../../shared/dumb_widgets/setting_menu_item.dart';
import '../../../../shared/dumb_widgets/statusbar.dart';
import 'settings_view_model.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
      viewModelBuilder: () => SettingsViewModel(),
      builder: (
        BuildContext context,
        SettingsViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          color: Colors.white,
          child: Scaffold(
              appBar: AppBar(
                title: Text(settingsText,
                    style: heading6Style.copyWith(
                      color: kcPrimaryColor,
                    )),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Column(children: [
                  verticalSpaceSmall,
                  SettingsMenuItem(
                      imgPath: profileIcon,
                      text: profileText,
                      onTap: model.gotoProfileSettingsView),
                  verticalSpaceSmall,
                  SettingsMenuItem(
                      imgPath: currencyIcon,
                      text: currencyText,
                      onTap: model.gotoChangeCurrency),
                  // verticalSpaceSmall,
                  // SettingsMenuItem(
                  //     imgPath: themeIcon,
                  //     text: themeText,
                  //     onTap: () {
                  //       Navigator.of(context).push(CupertinoPageRoute(
                  //           builder: (_) => const ThemeView()));
                  //     }),
                  verticalSpaceSmall,
                  // SettingsMenuItem(
                  //     imgPath: helpIcon, text: helpText, onTap: () {}),
                  // verticalSpaceSmall,
                  SettingsMenuItem(
                      imgPath: logoutIcon,
                      text: logoutText,
                      showArrow: false,
                      onTap: model.logout),
                ]),
              )),
        );
      },
    );
  }
}

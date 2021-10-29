import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/setting_menu_item.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:money_management/ui/views/auth/login/login_view.dart';
import 'package:money_management/ui/views/main/change_currency/change_currency_view.dart';
import 'package:money_management/ui/views/main/theme/theme_view.dart';
import 'package:money_management/ui/views/profile_setting/profile_setting_view.dart';
import 'package:stacked/stacked.dart';
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
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) => const ProfileSettingsView()));
                      }),
                  verticalSpaceSmall,
                  SettingsMenuItem(
                      imgPath: currencyIcon,
                      text: currencyText,
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) => const ChangeCurrencyView()));
                      }),
                  verticalSpaceSmall,
                  SettingsMenuItem(
                      imgPath: themeIcon,
                      text: themeText,
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (_) => const ThemeView()));
                      }),
                  verticalSpaceSmall,
                  SettingsMenuItem(
                      imgPath: helpIcon, text: helpText, onTap: () {}),
                  verticalSpaceSmall,
                  SettingsMenuItem(
                      imgPath: logoutIcon,
                      text: logoutText,
                      showArrow: false,
                      onTap: () {
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(
                                builder: (_) => const LoginView()));
                      }),
                ]),
              )),
        );
      },
    );
  }
}

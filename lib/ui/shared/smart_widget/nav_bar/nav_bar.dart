import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/smart_widget/nav_bar/nac_bar_model.dart';
import 'package:stacked/stacked.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavBarModel>.reactive(
        viewModelBuilder: () => NavBarModel(),
        builder: (context, model, child) => BottomNavigationBar(
              currentIndex: model.currentPageIndex,
              onTap: model.setCurrentPageIndex,
              selectedItemColor: kcPrimaryColor,
              unselectedItemColor: kcMiniGray,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              // selectedLabelStyle: heading6Style.copyWith(
              //     fontSize: 12,
              //     fontWeight: FontWeight.w500,
              //     color: kcPrimaryColor),
              // unselectedLabelStyle: heading6Style.copyWith(
              //     fontSize: 12, fontWeight: FontWeight.w500, color: kcMaxGray),
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(home, color: model.currentPageIndex == 0 ? kcPrimaryColor : kcMiniGray,), label: homeText),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(report, color: model.currentPageIndex == 1 ? kcPrimaryColor : kcMiniGray,), label: reportText),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(budget, color: model.currentPageIndex == 2 ? kcPrimaryColor : kcMiniGray,), label: budgetText),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset(settings, color: model.currentPageIndex == 3 ? kcPrimaryColor : kcMiniGray,), label: settingsText),
              ],
            ));
  }
}

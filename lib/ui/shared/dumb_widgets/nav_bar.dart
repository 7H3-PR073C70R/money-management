import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants/app_image_path.dart';
import '../../../constants/app_string.dart';
import '../../views/main/main_view_model.dart';

class NavBar extends StatelessWidget {
  final MainViewModel model;
  const NavBar({ Key? key, required this.model }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
              currentIndex: model.currentPageIndex,
              onTap: model.setCurrentPageIndex,
              selectedItemColor: kcPrimaryColor,
              unselectedItemColor: kcMiniGray,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
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
            );
  }
}
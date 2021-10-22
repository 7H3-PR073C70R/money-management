import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/smart_widget/nav_bar/nav_bar.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = screenHeiht(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            backgroundColor: Colors.white,
            bottomNavigationBar: const NavBar(),
            floatingActionButton:
                !model.showBottomSheet ? BuildFab(model: model) : null,
            bottomSheet: model.showBottomSheet
                ? BuildBottomSheet(
                    model: model,
                  )
                : null,
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                  ),
                  height: screenHeight * 0.20,
                  decoration: const BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Good morning',
                              style: heading6Style.copyWith(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          horizontalSpaceVeryTiny,
                          SvgPicture.asset(sunIcon),
                          const Spacer(),
                          IconButton(
                              onPressed: () {},
                              icon: SvgPicture.asset(noteIcon))
                        ],
                      ),
                      Text('Protector',
                          style: heading6Style.copyWith(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 38),
                  width: double.infinity,
                  child: IconButton(
                      onPressed: model.setShowBottomSheet,
                      icon: SvgPicture.asset(filter)),
                ),
                verticalSpaceSmall,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        BuildDetailsContainer(
                            title: totalIncomeText, amount: '#30,000'),
                        horizontalSpaceSmall,
                        BuildDetailsContainer(
                            title: totlaExpenseText, amount: '#17,000')
                      ],
                    ),
                    verticalSpaceSmall,
                    const BuildDetailsContainer(
                        title: balanceText, amount: '#13,000')
                  ],
                ),
                verticalSpaceSmall,
                SizedBox(
                  height: screenHeight * 0.25,
                  child: ListView.separated(
                      itemBuilder: (context, index) => BuildInfoContainer(
                            price: 'N17,000',
                            description: 'Food',
                            category: 'Expense',
                            date: DateFormat('dd MMM, yyyy     hh:mm')
                                .format(DateTime.now()),
                          ),
                      separatorBuilder: (context, index) => const Divider(
                            thickness: 1.5,
                          ),
                      itemCount: 6),
                )
              ],
            ));
      },
    );
  }
}

class BuildBottomSheet extends StatelessWidget {
  final HomeViewModel model;
  const BuildBottomSheet({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeiht(context) * 0.35,
      width: double.infinity,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.white),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 25,
                    ),
                    onPressed: model.setShowBottomSheet),
              )),
          BoxText.headingSix(filterByDateText),
          SizedBox(
            height: screenHeiht(context) * 0.23,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BuildFilterContainers(
                  text: todayText,
                  date: model.date[0],
                  isSelected: model.selectedFilterIndex == 0,
                  onTap: () => model.setSelectedFilterIndex(0),
                ),
                BuildFilterContainers(
                  text: yesterdayText,
                  date: model.date[1],
                  isSelected: model.selectedFilterIndex == 1,
                  onTap: () => model.setSelectedFilterIndex(1),
                ),
                BuildFilterContainers(
                  text: thisWeekText,
                  date: model.date[2],
                  isSelected: model.selectedFilterIndex == 2,
                  onTap: () => model.setSelectedFilterIndex(2),
                ),
                BuildFilterContainers(
                  text: lastMonthText,
                  date: model.getMonth(),
                  isSelected: model.selectedFilterIndex == 3,
                  onTap: () => model.setSelectedFilterIndex(3),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BuildFilterContainers extends StatelessWidget {
  final String text, date;
  final bool isSelected;
  final VoidCallback? onTap;
  const BuildFilterContainers(
      {Key? key,
      required this.text,
      required this.date,
      this.isSelected = false,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 37.0),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              calenderSvg,
              height: 20,
              width: 15,
              fit: BoxFit.cover,
            ),
            horizontalSpaceSmall,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: heading6Style.copyWith(
                      fontSize: 15, color: kcPrimaryColor),
                ),
                Text(
                  date,
                  style:
                      heading6Style.copyWith(fontSize: 15, color: kcNeutral5),
                ),
              ],
            ),
            const Spacer(),
            if (isSelected)
              const Padding(
                  padding: EdgeInsets.only(),
                  child: Icon(
                    Icons.check,
                    color: kcPrimaryColor,
                  ))
          ],
        ),
      ),
    );
  }
}

class BuildFab extends StatelessWidget {
  final HomeViewModel model;
  const BuildFab({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (model.isFabPressed)
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: FabContainer(
                      text: addNotesText,
                      onTap: () {},
                    )),
                verticalSpaceVeryTiny,
                Align(
                    alignment: Alignment.bottomRight,
                    child: FabContainer(
                      text: addExpenseText,
                      onTap: () {},
                    )),
                verticalSpaceVeryTiny,
                Align(
                    alignment: Alignment.bottomRight,
                    child: FabContainer(
                      text: addIncomeText,
                      onTap: () {},
                    )),
                verticalSpaceVeryTiny,
              ],
            ),
          Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  onPressed: model.setIsFabPressed,
                  backgroundColor: kcPrimaryColor,
                  child: Icon(
                    !model.isFabPressed ? Icons.add : Icons.close,
                    size: 35,
                  ))),
        ],
      ),
    );
  }
}

class BuildDetailsContainer extends StatelessWidget {
  final String title, amount;
  const BuildDetailsContainer(
      {Key? key, required this.title, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 142,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kcPrimaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: heading6Style.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w400)),
          Text(amount,
              style: heading6Style.copyWith(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }
}

class BuildInfoContainer extends StatelessWidget {
  final String date, category, description, price;
  final bool isIncome;
  const BuildInfoContainer(
      {Key? key,
      required this.date,
      required this.category,
      required this.description,
      required this.price,
      this.isIncome = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date,
              style: heading6Style.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              )),
          verticalSpaceSmall,
          Row(
            children: [
              Text(category,
                  style: heading6Style.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isIncome ? kcSecondaryColor : kcPrimaryColor)),
              horizontalSpaceMedium,
              Text(description,
                  style: heading6Style.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isIncome ? kcSecondaryColor : kcPrimaryColor)),
              const Spacer(),
              Text(price,
                  style: heading6Style.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isIncome ? kcSecondaryColor : kcPrimaryColor))
            ],
          )
        ],
      ),
    );
  }
}

class FabContainer extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  const FabContainer({Key? key, required this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 112,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: kcPrimaryColor,
        ),
        child: Center(
          child: Text(
            text,
            style: heading6Style.copyWith(color: Colors.white, fontSize: 13),
          ),
        ),
      ),
    );
  }
}

class BuildNoItemContainer extends StatelessWidget {
  const BuildNoItemContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(noItemSvg),
          verticalSpaceMedium,
          Text(noItemText,
              style: heading6Style.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center),
          BoxButton(
            title: noItemButtonText,
            onTap: () {},
          )
        ],
      ),
    );
  }
}

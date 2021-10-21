import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/smart_widget/nav_bar/nav_bar.dart';
import 'package:stacked/stacked.dart';

import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = screenHeiht(context);
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: kcPrimaryColor,
              elevation: 0,
            ),
            bottomNavigationBar: const NavBar(),
            body: Column(
              children: [
                Container(
                  height: screenHeight * 0.20,
                  decoration: const BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
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
                        Row(
                          children: [
                            Text('Protector',
                                style: heading6Style.copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600)),
                            // const Spacer(),
                            // SvgPicture.asset(circle)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                verticalSpaceSmall,
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 38),
                  width: double.infinity,
                  child: IconButton(
                      onPressed: () {}, icon: SvgPicture.asset(filter)),
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
      required this.price, this.isIncome = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(date, style: heading6Style.copyWith(fontSize: 12, fontWeight: FontWeight.w500,)),
          verticalSpaceSmall,
          Row(
            children: [
              Text(category, style: heading6Style.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: isIncome ? kcSecondaryColor : kcPrimaryColor )),
              horizontalSpaceMedium,
              Text(description, style: heading6Style.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: isIncome ? kcSecondaryColor : kcPrimaryColor )),
              const Spacer(),
              Text(price, style: heading6Style.copyWith(fontSize: 12, fontWeight: FontWeight.w500, color: isIncome ? kcSecondaryColor : kcPrimaryColor ))
            ],
          )
        ],
      ),
    );
  }
}

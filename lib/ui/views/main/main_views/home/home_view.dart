import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/bottom_sheet.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:money_management/ui/views/main/income_and_expenses/add_income_or_expenses_view.dart';
import 'package:money_management/ui/views/main/notes/add_note_view.dart';
import 'package:money_management/ui/views/main/notes/note_view.dart';
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
        return model.showNoteView ? NoteView(model: model) : StatusBar(
          color: kcPrimaryColor,
          child: Scaffold(
              backgroundColor: model.showBottomSheet ? Colors.grey : Colors.white,
              floatingActionButton:
                  !model.showBottomSheet ? BuildFab(model: model) : null,
              bottomSheet: model.showBottomSheet
                  ? Container(
                    color: Colors.grey,
                    child: BuildBottomSheet(selectedFilterIndex: model.selectedFilterIndex, setSelectedFilterIndex: model.setSelectedFilterIndex, setShowBottomSheet: model.setShowBottomSheet))
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
                                onPressed: model.setShowNoteView,
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
                  Container(
                    padding: const EdgeInsets.only(bottom: 70),
                    height: screenHeight - ((screenHeight * 0.20) + 290 + MediaQuery.of(context).viewInsets.bottom),
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
              )),
        );
      },
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
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> const AddNoteView()));
                      },
                    )),
                verticalSpaceVeryTiny,
                Align(
                    alignment: Alignment.bottomRight,
                    child: FabContainer(
                      text: addExpenseText,
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> const AddIncomeOrExpensesView(isIncome: false)));
                      },
                    )),
                verticalSpaceVeryTiny,
                Align(
                    alignment: Alignment.bottomRight,
                    child: FabContainer(
                      text: addIncomeText,
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(builder: (context)=> const AddIncomeOrExpensesView(isIncome: true)));
                      },
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

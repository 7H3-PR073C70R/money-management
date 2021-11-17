import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../../app/app.locator.dart';
import '../../../../../constants/app_image_path.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../model/incomde_and_expenses_model.dart';
import '../../../../../service/user_service.dart';
import '../../../../shared/const_color_helper.dart';
import '../../../../shared/const_ui_helper.dart';
import '../../../../shared/dumb_widgets/bottom_sheet.dart';
import '../../../../shared/dumb_widgets/no_item.dart';
import '../../../../shared/dumb_widgets/statusbar.dart';
import '../../income_and_expenses/add_income_or_expenses_view.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = screenHeiht(context);
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          color: kcPrimaryColor,
          child: Scaffold(
              backgroundColor:
                  model.showBottomSheet ? Colors.grey : Colors.white,
              floatingActionButton:
                  !model.showBottomSheet ? BuildFab(model: model) : null,
              bottomSheet: model.showBottomSheet
                  ? Container(
                      color: Colors.grey,
                      child: BuildBottomSheet(
                          onReset: () => model.setSelectedFilterIndex(-1),
                          selectedFilterIndex: model.selectedFilterIndex,
                          setSelectedFilterIndex: model.setSelectedFilterIndex,
                          setShowBottomSheet: model.setShowBottomSheet))
                  : null,
              body: SingleChildScrollView(
                child: Column(
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
                              Text(model.greeting,
                                  style: heading6Style.copyWith(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400)),
                              horizontalSpaceVeryTiny,
                              SvgPicture.asset(!model.greeting.contains('Evening') ? sunIcon : moonIcon, height: 25, color: Colors.yellowAccent),
                              const Spacer(),
                              IconButton(
                                  onPressed: model.navigateToNoteView,
                                  icon: SvgPicture.asset(noteIcon))
                            ],
                          ),
                          Text('${model.userFirstName}',
                              style: heading6Style.copyWith(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    verticalSpaceSmall,
                    model.isBusy
                        ? SizedBox(
                            height: screenHeiht(context) * 0.6,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ))
                        : model.incomeAndExpenses.isEmpty && model.selectedFilterIndex == -1
                            ? SizedBox(
                                height: screenHeiht(context) * 0.6,
                                child: const NoItem(
                                  text: noItemText,
                                ),
                              )
                            : Column(
                                children: [
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BuildDetailsContainer(
                                              title: totalIncomeText,
                                              amount: model.totalIncome),
                                          horizontalSpaceSmall,
                                          BuildDetailsContainer(
                                              title: totlaExpenseText,
                                              amount: model.totalExpenses)
                                        ],
                                      ),
                                      verticalSpaceSmall,
                                      BuildDetailsContainer(
                                          title: balanceText,
                                          amount: model.total)
                                    ],
                                  ),
                                  verticalSpaceSmall,
                                  model.incomeAndExpenses.isEmpty
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: SizedBox(
                                            height: screenHeight * 0.2,
                                            child: Card(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 32),
                                              color: kcNeutral9,
                                              child: Center(
                                                child: Text(
                                                  noDataFound,
                                                  textAlign: TextAlign.center,
                                                  style: heading6Style.copyWith(
                                                      color: kcPrimaryColor),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 70),
                                          height: screenHeight -
                                              ((screenHeight * 0.20) +
                                                  290 +
                                                  MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                          child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                IncomeAndExpenses currentValue =
                                                    model.incomeAndExpenses[
                                                        index];
                                                return Dismissible(
                                                  key: const Key('value'),
                                                  onDismissed: (_) {
                                                    model.deleteIncomeOrExpence(
                                                        currentValue, index);
                                                  },
                                                  confirmDismiss: (_) async {
                                                    bool value = false;
                                                    await showDialog(
                                                        context: context,
                                                        builder:
                                                            (context) =>
                                                                AlertDialog(
                                                                  actions: [
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          value =
                                                                              false;
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'No')),
                                                                    TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          value =
                                                                              true;
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        child: const Text(
                                                                            'Yes')),
                                                                  ],
                                                                  title: Text(
                                                                      'Warning!!!',
                                                                      style: heading6Style.copyWith(
                                                                          color:
                                                                              Theme.of(context).errorColor)),
                                                                  content:
                                                                      const Text(
                                                                    'Are you sure want to delete this budget?',
                                                                    maxLines: 2,
                                                                    style:
                                                                        bodyStyle,
                                                                  ),
                                                                ));
                                                    return Future.value(value);
                                                  },
                                                  background: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 20.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Icon(Icons.delete,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor),
                                                    ),
                                                  ),
                                                  child: BuildInfoContainer(
                                                    price:
                                                        '${model.currencySymbol}${NumberFormat('#,###.##').format(currentValue.amount)}',
                                                    description: currentValue
                                                        .description!,
                                                    category:
                                                        currentValue.category!,
                                                    isExpenses: currentValue
                                                        .isExpenses!,
                                                    date: currentValue.date !=
                                                            null
                                                        ? DateFormat(
                                                                'dd MMM, yyyy')
                                                            .format(currentValue
                                                                .date!)
                                                        : 'No Date',
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const Divider(
                                                        thickness: 1.5,
                                                      ),
                                              itemCount: model
                                                  .incomeAndExpenses.length),
                                        ),
                                ],
                              )
                  ],
                ),
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
                        onTap: model.navigateToAddNoteView)),
                verticalSpaceVeryTiny,
                Align(
                    alignment: Alignment.bottomRight,
                    child: FabContainer(
                      text: addExpenseText,
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const AddIncomeOrExpensesView(
                                isExpenses: true)));
                      },
                    )),
                verticalSpaceVeryTiny,
                Align(
                    alignment: Alignment.bottomRight,
                    child: FabContainer(
                      text: addIncomeText,
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => const AddIncomeOrExpensesView(
                                isExpenses: false)));
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
  final String title;
  final double amount;
  BuildDetailsContainer({Key? key, required this.title, required this.amount})
      : super(key: key);
  final userService = locator<UserService>();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Text(
                '${userService.currency}${NumberFormat('#,###').format(amount)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: heading6Style.copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600)),
          )
        ],
      ),
    );
  }
}

class BuildInfoContainer extends StatelessWidget {
  final String date, category, description, price;
  final bool isExpenses;
  const BuildInfoContainer(
      {Key? key,
      required this.date,
      required this.category,
      required this.description,
      required this.price,
      this.isExpenses = false})
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
                fontSize: 14,
                fontWeight: FontWeight.w500,
              )),
          verticalSpaceSmall,
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: screenWidth(context) * 0.2,
                child: Text(category,
                    style: heading6Style.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isExpenses ? kcSecondaryColor : kcPrimaryColor)),
              ),
              horizontalSpaceSmall,
              Container(
                alignment: Alignment.centerLeft,
                width: screenWidth(context) * 0.3,
                child: Text(description,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: heading6Style.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isExpenses ? kcSecondaryColor : kcPrimaryColor)),
              ),
              const Spacer(),
              SizedBox(
                width: screenWidth(context) * 0.2,
                child: Text(price,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: heading6Style.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isExpenses ? kcSecondaryColor : kcPrimaryColor)),
              )
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

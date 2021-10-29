import 'package:box_ui/box_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/app_image_path.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/bottom_sheet.dart';
import 'package:money_management/ui/shared/dumb_widgets/chart_indicator.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:stacked/stacked.dart';
import 'report_view_model.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ReportViewModel>.reactive(
      viewModelBuilder: () => ReportViewModel(),
      builder: (
        BuildContext context,
        ReportViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          child: Scaffold(
            backgroundColor: model.showBottomSheet ? kcNeutral6 : Colors.white,
            bottomSheet: model.showBottomSheet
                ? Container(
                    color: kcNeutral6,
                    child: BuildBottomSheet(
                        selectedFilterIndex: model.selectedFilterIndex,
                        setSelectedFilterIndex: model.setSelectedFilterIndex,
                        setShowBottomSheet: model.setShowBottomSheet))
                : null,
            body: SafeArea(
                child: Column(
              children: [
                verticalSpaceSmall,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BuildPageSwitcherContainer(
                      onTap: () => model.setCurrentPageIndex(0),
                      isSelected: model.currentPageIndex == 0,
                      isRight: false,
                      text: incomeText,
                    ),
                    BuildPageSwitcherContainer(
                      onTap: () => model.setCurrentPageIndex(1),
                      isSelected: model.currentPageIndex == 1,
                      isRight: true,
                      text: expenseText,
                    )
                  ],
                ),
                verticalSpaceSmall,
                Padding(
                  padding: EdgeInsets.only(right: screenWidth(context) * 0.09),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                        onPressed: model.setShowBottomSheet,
                        icon: SvgPicture.asset(filter)),
                  ),
                ),
                verticalSpaceSmall,
                model.currentPageIndex == 0
                    ? BuildIncomeContainer(model: model)
                    : BuildExpensesContainer(model: model)
              ],
            )),
          ),
        );
      },
    );
  }
}

class BuildPageSwitcherContainer extends StatelessWidget {
  final bool isSelected;
  final bool isRight;
  final String text;
  final VoidCallback onTap;
  const BuildPageSwitcherContainer(
      {Key? key,
      required this.onTap,
      required this.text,
      required this.isSelected,
      required this.isRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: screenWidth(context) * 0.40,
        decoration: BoxDecoration(
            borderRadius: isRight
                ? const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                : const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
            color: isSelected ? kcPrimaryColor : kcNeutral9),
        child: Center(
            child: Text(text,
                style: bodyStyle.copyWith(
                    color: isSelected ? Colors.white : kcNeutral6,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }
}

class BuildExpensesContainer extends StatelessWidget {
  final ReportViewModel model;
  const BuildExpensesContainer({Key? key, required this.model})
      : super(key: key);

  final colors = const [
    Color.fromRGBO(47, 115, 218, 1),
    Color.fromRGBO(82, 216, 88, 1),
    Color.fromRGBO(255, 196, 0, 1),
    Color.fromRGBO(19, 60, 114, 1),
    Color.fromRGBO(120, 120, 120, 1),
    Color.fromRGBO(172, 46, 183, 1),
    Color.fromRGBO(210, 103, 103, 1),
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: screenHeiht(context) * 0.30,
            child: Stack(
              children: [
                  Center(
                  child: SizedBox(
                    width: screenWidth(context) * 0.2,
                    child:   Text(
                      'N${NumberFormat('#,###').format(model.expensesTotal)}', 
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: heading6Style),
                  )
                ),
                SizedBox(
                  height: screenHeiht(context) * 0.30,
                  child: PieChart(PieChartData(
                      sectionsSpace: 0.5,
                      centerSpaceRadius: screenHeiht(context) * 0.1,
                      pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          model.setExpensesTouchIndex(-1);

                          return;
                        }
                        model.setExpensesTouchIndex(
                            pieTouchResponse.touchedSection!.touchedSectionIndex);
                      }),
                      sections: [
                        PieChartSectionData(
                          radius: model.isExpensesPieChartTouched(0) ? 60 : 30,
                            color: colors[0],
                            showTitle: false,
                            value: (model.expensesAmount[0] / model.expensesTotal) * 100),
                        PieChartSectionData(
                          radius: model.isExpensesPieChartTouched(1) ? 60 : 30,
                            color: colors[1],
                            showTitle: false,
                            value: (model.expensesAmount[1] / model.expensesTotal) * 100),
                            PieChartSectionData(
                          radius: model.isExpensesPieChartTouched(2) ? 60 : 30,
                            color: colors[2],
                            showTitle: false,
                            value: (model.expensesAmount[2] / model.expensesTotal) * 100),
                            PieChartSectionData(
                          radius: model.isExpensesPieChartTouched(3) ? 60 : 30,
                            color: colors[3],
                            showTitle: false,
                            value: (model.expensesAmount[3] / model.expensesTotal) * 100),
                            PieChartSectionData(
                          radius: model.isExpensesPieChartTouched(4) ? 60 : 30,
                            color: colors[4],
                            showTitle: false,
                            value: (model.expensesAmount[4] / model.expensesTotal) * 100),
                            PieChartSectionData(
                          radius: model.isExpensesPieChartTouched(5) ? 60 : 30,
                            color: colors[5],
                            showTitle: false,
                            value: (model.expensesAmount[5] / model.expensesTotal) * 100),
                            PieChartSectionData(
                          radius: model.isExpensesPieChartTouched(6) ? 60 : 30,
                            color: colors[6],
                            showTitle: false,
                            value: (model.expensesAmount[6] / model.expensesTotal) * 100),
                      ])),
                ),
              ],
            ),
          ),
          verticalSpaceVeryTiny,
          SizedBox(
            height: screenHeiht(context) * 0.3,
            child: Padding(
              padding: const EdgeInsets.only(left: 23, right: 23, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ChartIndicator(color: colors[0], amount: model.expensesAmount[0], value: 'Rant'),
                  ChartIndicator(color: colors[1], amount: model.expensesAmount[1], value: 'Food'),
                  ChartIndicator(color: colors[2], amount: model.expensesAmount[2], value: 'Health'),
                  ChartIndicator(color: colors[3], amount: model.expensesAmount[3], value: 'Data'),
                  ChartIndicator(color: colors[4], amount: model.expensesAmount[4], value: 'Entertainment'),
                  ChartIndicator(color: colors[5], amount: model.expensesAmount[5], value: 'Clothing'),
                  ChartIndicator(color: colors[6], amount: model.expensesAmount[6], value: 'Other'),
                ],
              ),
              ),
          )
        ],
      ),
    );

  }
}

class BuildIncomeContainer extends StatelessWidget {
  final ReportViewModel model;
  const BuildIncomeContainer({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: screenHeiht(context) * 0.30,
            child: Stack(
              children: [
                  Center(
                  child: SizedBox(
                    width: screenWidth(context) * 0.2,
                    child: Text(
                      'N${NumberFormat('#,###').format(model.incomeTotal)}', 
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: heading6Style),
                  )
                ),
                SizedBox(
                  height: screenHeiht(context) * 0.30,
                  child: PieChart(PieChartData(
                      sectionsSpace: 0.5,
                      centerSpaceRadius: screenHeiht(context) * 0.10,
                      pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          model.setIncomeTouchIndex(-1);

                          return;
                        }
                        model.setIncomeTouchIndex(
                            pieTouchResponse.touchedSection!.touchedSectionIndex);
                      }),
                      sections: [
                        PieChartSectionData(
                          radius: model.isIncomePieChartTouched(0) ? 60 : 30,
                            color: const Color.fromRGBO(82, 216, 88, 1),
                            showTitle: false,
                            value: (model.incomeAmount[0] / model.incomeTotal) * 100),
                        PieChartSectionData(
                          radius: model.isIncomePieChartTouched(1) ? 60 : 30,
                            color: const Color.fromRGBO(210, 103, 103, 1),
                            showTitle: false,
                            value: (model.incomeAmount[1] / model.incomeTotal) * 100),
                            PieChartSectionData(
                          radius: model.isIncomePieChartTouched(2) ? 60 : 30,
                            color: const Color.fromRGBO(47, 115, 218, 1),
                            showTitle: false,
                            value: (model.incomeAmount[2] / model.incomeTotal) * 100),
                            PieChartSectionData(
                          radius: model.isIncomePieChartTouched(3) ? 60 : 30,
                            color: const Color.fromRGBO(172, 46, 183, 1),
                            showTitle: false,
                            value: (model.incomeAmount[3] / model.incomeTotal) * 100),
                      ])),
                ),
              ],
            ),
          ),
          verticalSpaceVeryTiny,
          SizedBox(
            height: screenHeiht(context) * 0.2,
            child: Padding(
              padding: const EdgeInsets.only(left: 23, right: 23, bottom: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ChartIndicator(color: const Color.fromRGBO(82, 216, 88, 1), amount: model.incomeAmount[0], value: 'Salary'),
                  ChartIndicator(color: const Color.fromRGBO(210, 103, 103, 1), amount: model.incomeAmount[1], value: 'Business'),
                  ChartIndicator(color: const Color.fromRGBO(47, 115, 218, 1), amount: model.incomeAmount[2], value: 'Crypto Investment'),
                  ChartIndicator(color: const Color.fromRGBO(172, 46, 183, 1), amount: model.incomeAmount[3], value: 'Cash Gift'),
                ],
              ),
              ),
          )
        ],
      ),
    );
  }
}

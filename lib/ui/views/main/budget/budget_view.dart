import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/ui/shared/const_color_helper.dart';
import 'package:money_management/ui/shared/const_ui_helper.dart';
import 'package:money_management/ui/shared/dumb_widgets/statusbar.dart';
import 'package:stacked/stacked.dart';

import 'budget_view_model.dart';
import 'create_budget_view.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BudgetViewModel>.reactive(
      viewModelBuilder: () => BudgetViewModel(),
      onModelReady: (model) => model.setBudgetsToDisplay(),
      builder: (
        BuildContext context,
        BudgetViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          child: model.showCreateBudget
              ? CreateBudgetView(
                  model: model,
                )
              : Scaffold(
                  floatingActionButton: FloatingActionButton(
                    onPressed: model.setShowCreateBudget,
                    backgroundColor: kcPrimaryColor,
                    child: const Icon(
                      Icons.add,
                      size: 35,
                    ),
                  ),
                  appBar: AppBar(
                    title: Text(
                      budgetText,
                      style: heading6Style.copyWith(color: kcPrimaryColor),
                    ),
                    centerTitle: true,
                  ),
                  body: SafeArea(
                      child: Column(
                    children: [
                      verticalSpaceSmall,
                      Container(
                        height: model.budgetsToDisplay.length * 66.0,
                        constraints: BoxConstraints(
                            maxHeight: screenHeiht(context) * 0.55),
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) => Container(
                                  height: 61,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: kcNeutral9,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'N${NumberFormat('#,###').format(model.budgetsToDisplay[index].amount)}',
                                              style: heading6Style.copyWith(
                                                color: kcPrimaryColor,
                                                fontSize: 14,
                                              )),
                                          verticalSpaceVeryTiny,
                                          Text(
                                              '${model.budgetsToDisplay[index].category}',
                                              style: heading6Style.copyWith(
                                                fontWeight: FontWeight.w400,
                                                color: kcNeutral4,
                                                fontSize: 14,
                                              )),
                                        ],
                                      ),
                                      const Spacer(),
                                      Text(
                                          '${model.budgetsToDisplay[index].date}',
                                          style: heading6Style.copyWith(
                                            fontWeight: FontWeight.w400,
                                            color: kcNeutral4,
                                            fontSize: 14,
                                          )),
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, index) =>
                                verticalSpaceVeryTiny,
                            itemCount: model.budgetsToDisplay.length),
                      ),
                      verticalSpaceVeryTiny,
                      Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () => model.setCurrentIndex(true),
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: kcPrimaryColor, size: 22)),
                            horizontalSpaceVeryTiny,
                            Text('${model.currentIndex} of ${model.remainder}',
                                style: heading6Style.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: kcNeutral4,
                                  fontSize: 14,
                                )),
                            horizontalSpaceVeryTiny,
                            IconButton(
                                onPressed: () => model.setCurrentIndex(false),
                                icon: const Icon(Icons.arrow_forward_ios,
                                    color: kcPrimaryColor, size: 22)),
                          ],
                        ),
                      )
                    ],
                  ))),
        );
      },
    );
  }
}

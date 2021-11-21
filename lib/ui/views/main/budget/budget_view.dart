import 'package:box_ui/box_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../constants/app_string.dart';
import '../../../shared/const_color_helper.dart';
import '../../../shared/const_ui_helper.dart';
import '../../../shared/dumb_widgets/no_item.dart';
import '../../../shared/dumb_widgets/statusbar.dart';
import 'package:stacked/stacked.dart';
import 'budget_view_model.dart';

class BudgetView extends StatelessWidget {
  const BudgetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BudgetViewModel>.reactive(
      viewModelBuilder: () => BudgetViewModel(),
      onModelReady: (model) async => await model.init(),
      builder: (
        BuildContext context,
        BudgetViewModel model,
        Widget? child,
      ) {
        return StatusBar(
          child: Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => model.navigateToCreateBudget(model),
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
              body: model.isBusy
                  ? SizedBox(
                      height: screenHeiht(context) * 0.6,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ))
                  : model.budgetsToDisplay.isEmpty
                      ? const NoItem(text: noItemBudgetText)
                      : SafeArea(
                          child: Column(
                          children: [
                            verticalSpaceSmall,
                            Container(
                              height: model.budgetsToDisplay.length * 67.0,
                              constraints: BoxConstraints(
                                  maxHeight: screenHeiht(context) * 0.55),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => Dismissible(
                                        key: UniqueKey(),
                                        onDismissed: (_) {
                                          model.deleteBudget(
                                              model.budgetsToDisplay[index]);
                                        },
                                        confirmDismiss: (_) async {
                                          bool value = false;
                                          await showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            value = false;
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child:
                                                              const Text('No')),
                                                      TextButton(
                                                          onPressed: () {
                                                            value = true;
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: const Text(
                                                              'Yes')),
                                                    ],
                                                    title: Text('Warning!!!',
                                                        style: heading6Style
                                                            .copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .errorColor)),
                                                    content: const Text(
                                                      'Are you sure want to delete this budget?',
                                                      maxLines: 2,
                                                      style: bodyStyle,
                                                    ),
                                                  ));
                                          return Future.value(value);
                                        },
                                        background: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.delete,
                                                color: Theme.of(context)
                                                    .errorColor),
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () => model.gotoBudgetInfoView(
                                              model.budgetsToDisplay[index]),
                                          child: Container(
                                            height: 61,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 6),
                                            decoration: BoxDecoration(
                                                color: kcNeutral9,
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
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
                                                        '${model.currencySymbol}${NumberFormat('#,###').format(model.budgetsToDisplay[index].amount)}',
                                                        style: heading6Style
                                                            .copyWith(
                                                          color: kcPrimaryColor,
                                                          fontSize: 14,
                                                        )),
                                                    verticalSpaceVeryTiny,
                                                    Text(
                                                        '${model.budgetsToDisplay[index].category}',
                                                        style: heading6Style
                                                            .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: kcNeutral4,
                                                          fontSize: 14,
                                                        )),
                                                  ],
                                                ),
                                                const Spacer(),
                                                Text(
                                                    DateFormat('d MMM, yyyy')
                                                        .format(model
                                                            .budgetsToDisplay[
                                                                index]
                                                            .date!),
                                                    style:
                                                        heading6Style.copyWith(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: kcNeutral4,
                                                      fontSize: 14,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      verticalSpaceVeryTiny,
                                  itemCount: model.budgetsToDisplay.length),
                            ),
                            verticalSpaceVeryTiny,
                            if (model.remainder != 1)
                              Padding(
                                padding: const EdgeInsets.only(right: 6.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () =>
                                            model.setCurrentIndex(true),
                                        icon: const Icon(Icons.arrow_back_ios,
                                            color: kcPrimaryColor, size: 22)),
                                    horizontalSpaceVeryTiny,
                                    Text(
                                        '${model.currentIndex} of ${model.remainder}',
                                        style: heading6Style.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: kcNeutral4,
                                          fontSize: 14,
                                        )),
                                    horizontalSpaceVeryTiny,
                                    IconButton(
                                        onPressed: () =>
                                            model.setCurrentIndex(false),
                                        icon: const Icon(
                                            Icons.arrow_forward_ios,
                                            color: kcPrimaryColor,
                                            size: 22)),
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

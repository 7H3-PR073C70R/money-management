import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../app/app.router.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../model/budget_model.dart';
import '../../../../shared/const_color_helper.dart';
import '../../../../shared/const_ui_helper.dart';
import '../../../../shared/dumb_widgets/no_item.dart';
import '../../main_views/home/home_view.dart';
import 'package:stacked/stacked.dart';
import 'budget_info_view_model.dart';

class BudgetInfoView extends StatelessWidget {
  final Budget budget;
  const BudgetInfoView({Key? key, required this.budget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as BudgetInfoViewArguments;
    final budget = args.budget;
    return ViewModelBuilder<BudgetInfoViewModel>.reactive(
      viewModelBuilder: () => BudgetInfoViewModel(),
      onModelReady: (model) => model.init(budget),
      builder: (
        BuildContext context,
        BudgetInfoViewModel model,
        Widget? child,
      ) {
        return Scaffold(
            appBar: AppBar(
              title: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Budget',
                  style: heading6Style.copyWith(color: kcPrimaryColor),
                ),
              ),
              leading: IconButton(
                  onPressed: model.goBack,
                  icon: const Icon(Icons.arrow_back, color: Colors.black)),
              actions: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit',
                      style: heading6Style.copyWith(color: kcPrimaryColor),
                    ))
              ],
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () =>
                    model.gotoAddBudgetExpenses(model: model, budget: budget),
                child: const Icon(Icons.add),
                backgroundColor: kcPrimaryColor),
            body: Column(
              children: [
                SizedBox(
                  height: screenHeiht(context) * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BuildAmountContainer(
                        title: budgetTotalText,
                        amount: budget.amount!,
                        currencySymbol: model.currencySymbol,
                      ),
                      BuildAmountContainer(
                        title: budgetBalanceText,
                        amount: model.balance,
                        currencySymbol: model.currencySymbol,
                      ),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                SizedBox(
                  height: (screenHeiht(context) * 0.8) - kToolbarHeight,
                  child: model.expenses.isEmpty
                      ? const NoItem(text: noExpensesAssociatedText)
                      : ListView.separated(
                          itemCount: model.expenses.length,
                          separatorBuilder: (context, index) => const Divider(
                            height: 5,
                            thickness: 2,
                          ),
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: BuildInfoContainer(
                              price:
                                  '${model.currencySymbol}${NumberFormat('#,###').format(model.expenses[index].amount!)}',
                              description:
                                  '${model.expenses[index].description}',
                              category: '${model.expenses[index].category}',
                              date: DateFormat('dd MMM, yyyy hh:mm')
                                  .format(model.expenses[index].date!),
                            ),
                          ),
                        ),
                )
              ],
            ));
      },
    );
  }
}

class BuildAmountContainer extends StatelessWidget {
  final String title;
  final String currencySymbol;
  final double amount;
  const BuildAmountContainer(
      {Key? key,
      required this.title,
      required this.amount,
      required this.currencySymbol})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: screenWidth(context) * 0.35,
      padding: const EdgeInsets.only(left: 9),
      decoration: BoxDecoration(
          color: kcNeutral9,
          border: Border.all(color: const Color.fromRGBO(168, 177, 189, 1)),
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: bodyStyle.copyWith(color: kcNeutral4, fontSize: 14),
          ),
          Text(
            '$currencySymbol${NumberFormat('#,###.##').format(amount)}',
            style: bodyStyle.copyWith(color: kcPrimaryColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          )
        ],
      ),
    );
  }
}

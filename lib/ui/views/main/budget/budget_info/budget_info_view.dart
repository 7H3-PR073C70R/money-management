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
    final amountController = TextEditingController();
    return ViewModelBuilder<BudgetInfoViewModel>.reactive(
      viewModelBuilder: () => BudgetInfoViewModel(),
      onDispose: (model) => amountController.dispose(),
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
              // actions: [
              //   Padding(
              //     padding: const EdgeInsets.only(right: 15.0),
              //     child: IconButton(
              //         onPressed: () {
              //           showDialog(
              //               context: context,
              //               builder: (context) => AlertDialog(
              //                     title: const Text('Increase Budget'),
              //                     content: SizedBox(
              //                       height: screenHeiht(context) * 0.2,
              //                       child: Column(
              //                         children: [
              //                           BoxInputField(
              //                             label: 'Amount',
              //                             placeHolder: budget.amount.toString(),
              //                             controller: amountController,
              //                           ),
              //                           verticalSpaceSmall,
              //                           BoxButton(
              //                             title: 'Save',
              //                             onTap: () => model.updateBudget(
              //                                 budget.copyWith(
              //                                     amount: double.tryParse(
              //                                         amountController.text))),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ));
              //         },
              //         icon: const Icon(
              //           Icons.edit,
              //           color: kcPrimaryColor,
              //         )),
              //   )
              // ],
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
                        amount: budget.amount! - model.balance,
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
                            child: Dismissible(
                              key: UniqueKey(),
                              onDismissed: (_) {
                                model.deleteBudgetExpenses(
                                    indexToDelete: index);
                              },
                              background: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.delete,
                                      color: Theme.of(context).errorColor),
                                ),
                              ),
                              confirmDismiss: (_) async {
                                bool value = false;
                                await showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  value = false;
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('No')),
                                            TextButton(
                                                onPressed: () {
                                                  value = true;
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Yes')),
                                          ],
                                          title: Text('Warning!!!',
                                              style: heading6Style.copyWith(
                                                  color: Theme.of(context)
                                                      .errorColor)),
                                          content: const Text(
                                            'Are you sure want to delete this budget?',
                                            maxLines: 2,
                                            style: bodyStyle,
                                          ),
                                        ));
                                return Future.value(value);
                              },
                              child: BuildInfoContainer(
                                price:
                                    '${model.currencySymbol}${NumberFormat('#,###').format(model.expenses[index].amount!)}',
                                description:
                                    '${model.expenses[index].description}',
                                category: '${model.expenses[index].category}',
                                date: DateFormat('dd MMM, yyyy')
                                    .format(model.expenses[index].date!),
                              ),
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

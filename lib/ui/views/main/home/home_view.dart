import 'package:flutter/material.dart';
import 'package:money_management/ui/shared/dumb_widgets/nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';
import 'widgets/budget/budget_view.dart';
import 'widgets/home/home_view.dart';
import 'widgets/report/report_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  final _pages = const [ HomeWidget(), ReportWidget(), BudgetView(), Text('andrew')];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (
        BuildContext context,
        HomeViewModel model,
        Widget? child,
      ) {
        return Scaffold(
          bottomNavigationBar: NavBar(model: model,),
          body: _pages[model.currentPageIndex]
        );
      },
    );
  }
}
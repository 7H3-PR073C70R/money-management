import 'package:flutter/material.dart';
import '../../shared/dumb_widgets/nav_bar.dart';
import 'package:stacked/stacked.dart';
import 'budget/budget_view.dart';
import 'main_view_model.dart';
import 'main_views/home/home_view.dart';
import 'main_views/report/report_view.dart';
import 'main_views/settings/settings_view.dart';

class MainView extends StatelessWidget {
  const MainView({Key? key}) : super(key: key);
  final _pages = const [ HomeView(), ReportView(), BudgetView(), SettingsView()];
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainViewModel>.reactive(
      viewModelBuilder: () => MainViewModel(),
      builder: (
        BuildContext context,
        MainViewModel model,
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
import 'package:flutter/cupertino.dart';
import '../../../../app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import '../login_or_signup/login_or_signup_view.dart';
import 'package:stacked/stacked.dart';

class StartUpViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  int _index = 0;
  final List _doc = [
    {
      'title': 'Track your finances',
      'subtitle': '''Monitor all incoming and 
      outgoing expenses''',
      'image': 'assets/images/onboarding1.svg'
    },
    {
      'title': 'Create a Budget',
      'subtitle': '''  Easily create a budget, stating 
what comes in and what goes out''',
      'image': 'assets/images/onboarding2.svg'
    },
    {
      'title': 'Spend Wisely',
      'subtitle': '''Be in charge of 
your finances''',
      'image': 'assets/images/onboarding3.svg'
    }
  ];

  void updateIndex(bool isReversed) {
    if (isReversed) {
      if (_index > 0) {
        _index--;
      }
    } else {
      if (_index < 2) {
        _index++;
      }
    }
    notifyListeners();
  }

  void gotoLoginOrSignUP() {
   _navigationService.pushNamedAndRemoveUntil(Routes.loginOrSignUpView);
  }

  int get index => _index;

  List get doc => _doc;
}

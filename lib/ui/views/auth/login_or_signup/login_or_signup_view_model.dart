import '../../../../app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

class LoginOrSignUPViewModel extends BaseViewModel {
  final _navigationService = NavigationService();


  void gotoLogin() {
    _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }

  void gotoSignUP() {
    _navigationService.pushNamedAndRemoveUntil(Routes.signUpView);
    }
}
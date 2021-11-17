import 'package:money_management/app/app.locator.dart';
import 'package:money_management/app/app.router.dart';
import 'package:money_management/service/auth_service.dart';
import 'package:money_management/service/shared_prefs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _authService = AuthService();
  final _sharedPrefsService = locator<SharedPresService>();
  final _navigationService = NavigationService();

  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    if(_authService.isUserLoggedIn) {
      _navigationService.navigateTo(Routes.mainView);
      return;
    } else if(_sharedPrefsService.user != null) {
      _navigationService.navigateTo(Routes.loginView);
      return;
    }
    _navigationService.navigateTo(Routes.startUpView);
  }
}
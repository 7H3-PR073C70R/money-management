import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../service/auth_service.dart';
import '../../../service/shared_prefs.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  final _authService = AuthService();
  final _sharedPrefsService = locator<SharedPresService>();
  final _navigationService = NavigationService();

  //init method
  void init() async {
    await Future.delayed(const Duration(seconds: 2));
    if(_authService.isUserLoggedIn) {
      _navigationService.pushNamedAndRemoveUntil(Routes.mainView);
      return;
    } else if(_sharedPrefsService.user != null) {
      _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
      return;
    }
    _navigationService.pushNamedAndRemoveUntil(Routes.startUpView);
  }
}
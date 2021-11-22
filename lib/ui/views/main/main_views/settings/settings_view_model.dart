import '../../../../../app/app.router.dart';
import '../../../../../service/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SettingsViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  final _authService = AuthService();
  void gotoProfileSettingsView() {
    _navigationService.navigateTo(Routes.profileSettingsView);
  }

  void gotoChangeCurrency(){
    _navigationService.navigateTo(Routes.changeCurrencyView);
  }

  void logout() {
    _authService.signOut();
    _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }

}
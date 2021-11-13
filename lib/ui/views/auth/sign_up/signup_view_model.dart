import '../../../../app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  bool _isPasswordVisible = true;

  bool get passwordVisibility => _isPasswordVisible;

  void setPasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void gotoConfirmPassword() {
    _navigationService.pushNamedAndRemoveUntil(Routes.confirmEmailView);
  }

  void gotoLogin() {
    _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }
}

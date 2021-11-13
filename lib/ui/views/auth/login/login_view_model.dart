import '../../../../app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  bool _isPasswordVisible = false;
  get isPasswordVisible => _isPasswordVisible;

  setIsPasswordVisible() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void navigateToForgetPassword() {
    _navigationService.navigateTo(Routes.forgetPasswordView);
  }

  void navigateToMainView() {
    _navigationService.pushNamedAndRemoveUntil(Routes.mainView);
  }

  void navigateToSignUpView() {
    _navigationService.pushNamedAndRemoveUntil(Routes.signUpView);
  }
}
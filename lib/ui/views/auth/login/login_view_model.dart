import '../../../../app/app.logger.dart';
import '../../../../service/auth_service.dart';

import '../../../../app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  final _authService = AuthService();
  final log = getLogger('Login view model');
  String _email = '';
  String _password = '';

  bool _isPasswordNotVisible = true;
  get isPasswordVisible => _isPasswordNotVisible;

  setIsPasswordVisible() {
    _isPasswordNotVisible = !_isPasswordNotVisible;
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

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  Future<void> login() async {
    log.i('email: $_email & password: $_password');
    try {
      await runBusyFuture(
          _authService.signInWithCred(
              email: _email.trim(), password: _password),
          throwException: true);
      navigateToMainView();
    } catch (e) {
      log.i(e);
      if (e.toString().contains('veri')) {
        _navigationService.navigateTo(Routes.confirmEmailView,
            arguments: ConfirmEmailViewArguments(
                email: _email.trim(), isConfirmEmail: true));
      }
    }
  }
}

import '../../../../app/app.logger.dart';
import '../../../../model/user_model.dart';
import '../../../../service/auth_service.dart';
import '../../../../app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  final log = getLogger('SignUpViewModel');

  final _authService = AuthService();
  bool _isPasswordVisible = true;

  bool get passwordVisibility => _isPasswordVisible;

  void setPasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void gotoConfirmPassword(String email) {
    _navigationService.pushNamedAndRemoveUntil(Routes.confirmEmailView, arguments: ConfirmEmailViewArguments(email: email));
  }

  void gotoLogin() {
    _navigationService.pushNamedAndRemoveUntil(Routes.loginView);
  }

  void signUp({required User user, required String password}) async {
    try {
      await runBusyFuture(_authService.signUpWithCred(
          password: password,
          email: user.email!,
          firstName: user.fname!,
          lastName: user.lname!), throwException: true);
      gotoConfirmPassword(user.email!);
    } catch (e) {
      log.i(e);
    }
  }

  void signUpWithGoogle() async {
    try {
      await _authService.signInWithGoogle();
    } catch (e) {
      log.i(e);
    }
  }
}

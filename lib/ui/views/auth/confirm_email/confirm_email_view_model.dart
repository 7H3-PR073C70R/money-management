import '../../../../app/app.logger.dart';
import '../../../../app/app.router.dart';
import '../../../../service/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ConfirmEmailViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  final _authService = AuthService();
  final log = getLogger('ConfirmEmailViewModel');

  void gotoLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }

  void sendVerificationCode(bool isConfirmEmail, [String email = '']) async {
    try {
      await runBusyFuture(
          isConfirmEmail
              ? _authService.sendConfirmationEmail()
              : _authService.resetPassword(email: email),
          throwException: true);
    } catch (e) {
      log.i(e);
    }
  }
}

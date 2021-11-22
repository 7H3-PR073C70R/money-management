import '../../../../app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../../app/app.logger.dart';
import '../../../../service/auth_service.dart';
import 'package:stacked/stacked.dart';

class ForgetPasswordViewModel extends BaseViewModel {
  final _authService = AuthService();
  final _navigationService = NavigationService();
  final log = getLogger('ForgetPasswordViewModel');

  void sendResetPasswordLink(String email) async {
    try {
      await runBusyFuture(_authService.resetPassword(email: email.trim()), throwException: true);
      _gotoConfirmEmail(email);
    } catch (e) {
      log.i(e);
    }
  }

  void _gotoConfirmEmail(String email) {
    _navigationService.navigateTo(Routes.confirmEmailView,
        arguments: ConfirmEmailViewArguments(email: email, isConfirmEmail: false));
  }

  void gotoBack() {
    _navigationService.popRepeated(1);
  }
}

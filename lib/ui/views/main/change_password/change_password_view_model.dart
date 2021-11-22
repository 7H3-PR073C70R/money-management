import '../../../../app/app.logger.dart';
import '../../../../service/auth_service.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordViewModel extends BaseViewModel {
  bool _currentPasswordVisibility = true;
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;
  final _log = getLogger('ChangePasswordViewModel');
  final _authService = AuthService();

  bool get currentPasswordVisibility => _currentPasswordVisibility;
  bool get passwordVisibility => _passwordVisibility;
  bool get confirmPasswordVisibility => _confirmPasswordVisibility;

  void setCurrentPasswordVisibility() {
    _currentPasswordVisibility = !_currentPasswordVisibility;
    notifyListeners();
  }

  void setPasswordVisibility() {
    _passwordVisibility = !_passwordVisibility;
    notifyListeners();
  }

  void setConfirmPasswordVisibility() {
    _confirmPasswordVisibility = !_confirmPasswordVisibility;
    notifyListeners();
  }

  void updateUserPassword({required String oldPassword, required String newPassword}) async {
    try {
      await runBusyFuture(_authService.changePassword(newPassword));
    } catch (e) {
      _log.i(e);
    }
  }

}
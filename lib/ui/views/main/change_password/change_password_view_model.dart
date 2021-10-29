import 'package:stacked/stacked.dart';

class ChangePasswordViewModel extends BaseViewModel {
  bool _currentPasswordVisibility = true;
  bool _passwordVisibility = true;
  bool _confirmPasswordVisibility = true;

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

}
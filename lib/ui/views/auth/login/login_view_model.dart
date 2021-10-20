import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  bool _isPasswordVisible = false;
  get isPasswordVisible => _isPasswordVisible;

  setIsPasswordVisible() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }
}
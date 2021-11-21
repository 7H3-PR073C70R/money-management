import '../../../../app/app.locator.dart';
import '../../../../constants/app_string.dart';
import '../../../../constants/enums.dart';
import '../../../../service/shared_prefs.dart';
import '../../../../service/user_service.dart';
import 'package:stacked/stacked.dart';

class ChangeCurrencyViewModel extends BaseViewModel {
  final _sharedPrefes = locator<SharedPresService>();
  final _userService = locator<UserService>();
  int _selectedIndex = 3;
  final List<Currencies> _currencies = [
    Currencies.usd,
    Currencies.euro,
    Currencies.gpb,
    Currencies.ngn,
    Currencies.zar,
    Currencies.jpy,
  ];
  final List<String> _currenciesName = [
    usdText,
    euroText,
    gbpText,
    ngnText,
    zarText,
    jpyText,
  ];
  List<Currencies> get currencies => _currencies;
  List<String> get currenciesName => _currenciesName;
  int get selectedIndex => _selectedIndex;

  Currencies _selectedCurrency = Currencies.ngn;
  Currencies get selectedCurrency => _selectedCurrency;

  void setSelectedCurrency(Currencies value) {
    _selectedCurrency = value;
    _selectedIndex = currencies.indexOf(value);
    notifyListeners();
  }

  void setDefaultCurrency(){
    _selectedCurrency = Currencies.ngn;
    _selectedIndex = 3;
    notifyListeners();
  }

  void saveCurrency() {
    _sharedPrefes.saveUser(_userService.user.copyWith(currency: _selectedCurrency,));
  }

  void setCurrency() {
    try {
      setSelectedCurrency(_userService.user.currency!);
    } catch (e) {
      _selectedCurrency = Currencies.ngn;
    }
    notifyListeners();
  }
}

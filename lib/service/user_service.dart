import 'package:money_management/app/app.locator.dart';
import 'package:money_management/constants/enums.dart';
import 'package:money_management/model/user_model.dart';
import 'package:money_management/service/shared_prefs.dart';

class UserService {
  final _sharedPrefsService = locator<SharedPresService>();
  User get user {
      return _sharedPrefsService.user ?? User(
        id: '',
        fname: 'toxic',
        lname: 'bishop',
        email: 'toxic@bishop.com',
      );
  }

  String get currency {
    final _user = user;
    try {
      final currency = _user.currency;
      switch (currency) {
        case Currencies.usd:
          return '\$';
        case Currencies.euro:
          return '€';
        case Currencies.gpb:
          return '£';
        case Currencies.ngn:
          return '₦';
        case Currencies.zar:
          return 'R';
        case Currencies.jpy:
          return '¥';
        default:
          return '₦';
      }
    } catch (e) {
      return '';
    }
  }
}

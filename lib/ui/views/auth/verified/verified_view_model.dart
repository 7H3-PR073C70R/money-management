import '../../../../app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class VerifiedViewModel extends BaseViewModel {
  final _naviagtionService = NavigationService();
  void gotoLogin() {
    _naviagtionService.navigateTo(Routes.loginView);
  }
}
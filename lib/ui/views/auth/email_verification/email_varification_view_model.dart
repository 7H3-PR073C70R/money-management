import '../../../../app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class EmailVarificationViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  navigateToVerifyView() {
    _navigationService.navigateTo(Routes.verifiedView);
  }
  
}
import 'package:stacked/stacked.dart';

class NavBarModel extends BaseViewModel {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;

  void setCurrentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}
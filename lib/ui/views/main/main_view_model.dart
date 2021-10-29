import 'package:stacked/stacked.dart';

class MainViewModel extends BaseViewModel {
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  bool _isFabPressed = false;
  bool _showBottomSheet = false;
  int _selectedFilterIndex = 0;
  bool get isFabPressed => _isFabPressed;
  bool get showBottomSheet => _showBottomSheet;
  int get selectedFilterIndex => _selectedFilterIndex;


  void setIsFabPressed() {
    _isFabPressed = !_isFabPressed;
    notifyListeners();
  }

  setSelectedFilterIndex(index) {
    _selectedFilterIndex = index;
    setShowBottomSheet();
    notifyListeners();
  }

  void setShowBottomSheet() {
    _showBottomSheet = !_showBottomSheet;
    notifyListeners();
  }


  void setCurrentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  bool _isFabPressed = false;
  bool _showBottomSheet = false;
  bool _showNoteView = false;
  int _selectedFilterIndex = 0;
  bool get isFabPressed => _isFabPressed;
  bool get showNoteView => _showNoteView;
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

  void setShowNoteView() {
    _showNoteView = !_showNoteView;
    notifyListeners();
  }

  
}

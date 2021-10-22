import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  bool _isFabPressed = false;
  bool _showBottomSheet = false;
  int _selectedFilterIndex = 0;
  final List<String> _date = [
    DateFormat('MMM dd').format(DateTime.now()),
    DateFormat('MMM dd')
        .format(DateTime.now().subtract(const Duration(days: 1))),
    '${DateFormat('MMM dd').format(DateTime.now().subtract(Duration(days: DateTime.now().weekday)))} - ${DateFormat('MMM dd').format(DateTime.now())}',
  ];

  bool get isFabPressed => _isFabPressed;
  bool get showBottomSheet => _showBottomSheet;
  int get selectedFilterIndex => _selectedFilterIndex;
  List<String> get date => _date;

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

  String getMonth() {
    final int _currentMonthIndex = DateTime.now().month;
    switch(_currentMonthIndex) {
      case 1: 
        return 'Jan 1 - 31';
      case 2: 
        return 'Feb 1 - 29';
      case 3: 
        return 'Mar 1 - 31';
      case 4: 
        return 'Apr 1 - 30';
      case 5: 
        return 'May 1 - 31';
      case 6: 
        return 'Jun 1 - 30';
      case 7: 
        return 'Jul 1 - 31';
      case 8: 
        return 'Aug 1 - 31';
      case 9: 
        return 'Sep 1 - 31';
      case 10: 
        return 'Oct 1 - 31';
      case 11: 
        return 'Nov 1 - 30';
      case 12: 
        return 'Dec 1 - 31';
      default: 
        return '';
    }
  }
}

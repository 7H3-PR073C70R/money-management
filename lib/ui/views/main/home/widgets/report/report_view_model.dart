import 'package:stacked/stacked.dart';

class ReportViewModel extends BaseViewModel {
  int _currentPageIndex = 0;
  int _selectedFilterIndex = 0;
  bool _showBottomSheet = false;
  int _incomeTouchIndex = -1;
  int _expensesTouchIndex = -1;

  int get incomeTouchIndex => _incomeTouchIndex;
  int get expensesTouchIndex => _expensesTouchIndex;
  int get currentPageIndex => _currentPageIndex;
  bool get showBottomSheet => _showBottomSheet;
  int get selectedFilterIndex => _selectedFilterIndex;
  bool isIncomePieChartTouched(int index) => index == _incomeTouchIndex;
  bool isExpensesPieChartTouched(int index) => index == _expensesTouchIndex;

  final List<int> _incomeAmount = [10000, 10000, 5000, 5000];
  final List<int> _expensesAmount = [2000, 2000, 1500, 1000, 3000, 3500, 2000];
  List<int> get incomeAmount => _incomeAmount;
  List<int> get expensesAmount => _expensesAmount;

  int get incomeTotal {
    int total = 0;
    for (var value in _incomeAmount) {total += value;}
    return total;
  }

  int get expensesTotal {
    int total = 0;
    for (var value in _expensesAmount) {total += value;}
    return total;
  }

  void setCurrentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }

  void setIncomeTouchIndex(int index) {
    _incomeTouchIndex = index;
    notifyListeners();
  }

  void setExpensesTouchIndex(int index) {
    _expensesTouchIndex = index;
    notifyListeners();
  }

  void setShowBottomSheet() {
    _showBottomSheet = !_showBottomSheet;
    notifyListeners();
  }

  setSelectedFilterIndex(index) {
    _selectedFilterIndex = index;
    setShowBottomSheet();
    notifyListeners();
  }
}
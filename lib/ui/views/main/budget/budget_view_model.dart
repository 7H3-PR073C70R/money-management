import 'package:money_management/model/budget_model.dart';
import 'package:stacked/stacked.dart';

class BudgetViewModel extends BaseViewModel {
  int _currentIndex = 1;
  bool _showCreateBudget = false;

  get showCreateBudget => _showCreateBudget;
  get currentIndex => _currentIndex;
  final List<String> _category = [
    '<None>',
    'Rent',
    'Food',
    'Electricity',
    'Health',
    'Transportation',
    'Data',
    'Clothing',
    'Entertainment',
    'Others'
  ];
  String _categoryValue = '<None>';
  get categoryValue => _categoryValue;

  String _date = '';
  get date => _date;

  final List<Budget> _budgets = [
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 5000, description: '', category: 'Transportation', date: 'Jun, 2021'),
    Budget(amount: 12000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Eduation', date: 'Jun, 2021'),
    Budget(amount: 5000, description: '', category: 'Transportation', date: 'Jun, 2021'),
    Budget(amount: 12000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 5000, description: '', category: 'Transportation', date: 'Jun, 2021'),
    Budget(amount: 12000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 5000, description: '', category: 'Transportation', date: 'Jun, 2021'),
    Budget(amount: 12000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 5000, description: '', category: 'Transportation', date: 'Jun, 2021'),
    Budget(amount: 12000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Education', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Health', date: 'Jun, 2021'),
    Budget(amount: 20000, description: '', category: 'Health', date: 'Jun, 2021'),
  ];
  List<String> get category => _category;
  List<Budget> _budgetsToDisplay = [];
  List<Budget> get budgetsToDisplay => _budgetsToDisplay;
  
  int get remainder {
    int _remainder = _budgets.length % 5 == 0 ? _budgets.length ~/ 5 : (_budgets.length ~/ 5) + 1;
    return _remainder < 1 ? 1 : _remainder;
  }

  void setCategoryValue(value) {
    _categoryValue = value;
    notifyListeners();
  }

  void setCurrentIndex(bool isBacked) {
    switch(isBacked) {
      case true:
        if(_currentIndex != 1) {
          _currentIndex -= 1;
        }
        break;
      default:
        if(_currentIndex < remainder) {
          _currentIndex += 1;
        }
    }
    if(_currentIndex != remainder) {
      _budgetsToDisplay = _budgets.sublist(_currentIndex == 1 ? 0  : (_currentIndex * 5) - 5 , (_currentIndex * 5));
    } else {
      _budgetsToDisplay = _budgets.sublist((_currentIndex * 5) - 5);
    }
    notifyListeners();
  }

  void setBudgetsToDisplay() {
    _budgetsToDisplay = _budgets.length < 5 ? _budgets : _budgets.sublist(0,5);
  }

  void setDate(String value){
    _date = value;
    notifyListeners();
  }

  void setShowCreateBudget(){
    _showCreateBudget = !_showCreateBudget;
    notifyListeners();
  }
}
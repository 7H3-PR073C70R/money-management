import 'package:money_management/constants/app_string.dart';
import 'package:money_management/model/budget_model.dart';
import 'package:money_management/service/db_service.dart';
import 'package:stacked/stacked.dart';

class BudgetViewModel extends BaseViewModel {
  /// the current index of the first five list shown in the view.
  int _currentIndex = 1;

  /// To know if the createbudget view is to shown or not.
  bool _showCreateBudget = false;

  get showCreateBudget => _showCreateBudget;
  get currentIndex => _currentIndex;

  /// A list of categories for users to choose from.
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
  String get date => _date;

  String _amount = '';
  String _description = '';

  List<Budget> _budgets = [];
  List<String> get category => _category;
  List<Budget> _budgetsToDisplay = [];
  List<Budget> get budgetsToDisplay => _budgetsToDisplay;

  /// The method get the list of budgets saved to the db and also get the first 5 element of the
  /// list to be displayed in the view.
  Future<void> init() async {
    final Budget budget = Budget();
    final List<dynamic> result = await DataBaseService.instance
        .readAll(obj: budget, table: budgetTableName);
    _budgets = result.cast<Budget>();
    _budgetsToDisplay = _budgets.length < 5 ? _budgets : _budgets.sublist(0, 5);
    notifyListeners();
  }

  int get remainder {
    int _remainder = _budgets.length % 5 == 0
        ? _budgets.length ~/ 5
        : (_budgets.length ~/ 5) + 1;
    return _remainder < 1 ? 1 : _remainder;
  }

  /// This method set the category user selected.
  void setCategoryValue(value) {
    _categoryValue = value;
    notifyListeners();
  }

  /// This method set the current index and update [_budgetsToDisplay].
  void setCurrentIndex(bool isBacked) {
    switch (isBacked) {
      case true:
        if (_currentIndex != 1) {
          _currentIndex -= 1;
        }
        break;
      default:
        if (_currentIndex < remainder) {
          _currentIndex += 1;
        }
    }
    if (_currentIndex != remainder) {
      _budgetsToDisplay = _budgets.sublist(
          _currentIndex == 1 ? 0 : (_currentIndex * 5) - 5,
          (_currentIndex * 5));
    } else {
      _budgetsToDisplay = _budgets.sublist((_currentIndex * 5) - 5);
    }
    notifyListeners();
  }

  /// This method set the date
  void setDate(String value) {
    _date = value;
    notifyListeners();
  }

  /// The method update the value of [_showCreateBudget]. Which is used to determine
  /// if the create budget view is to be shown instead of the budger view.
  void setShowCreateBudget() {
    _showCreateBudget = !_showCreateBudget;
    notifyListeners();
  }

  void setAmount(String value) {
    _amount = value;
    notifyListeners();
  }

  void setDescription(String value) {
    _description = value;
    notifyListeners();
  }

  /// This method insert data into the Budget table using the database service and then insert
  /// the created budget to the list then update the value of [!_showCreateBudget] to take
  /// user back to the budget view.
  void createBudget() async {
    Budget budget = Budget(
        category: _categoryValue,
        description: _description,
        date: _date,
        amount: double.parse(_amount));
    final result = await runBusyFuture(DataBaseService.instance.create(
        obj: budget,
        table: budgetTableName));
    budget = result as Budget;
    _budgets.insert(0, budget);
    _showCreateBudget = !_showCreateBudget;
    notifyListeners();
  }
}

import 'package:intl/intl.dart';
import 'package:money_management/model/budget_expense_model.dart';
import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../constants/app_string.dart';
import '../../../../model/budget_model.dart';
import '../../../../service/db_service.dart';
import '../../../../service/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BudgetViewModel extends BaseViewModel {
  final _dbService = locator<DataBaseService>();
  final _userService = locator<UserService>();
  final _navigationService = NavigationService();

  String get currencySymbol => _userService.currency;

  /// the current index of the first five list shown in the view.
  int _currentIndex = 1;

  /// to know the state to  put the view in. It's true initial since the view is busy
  /// immediately it come into display

  bool _isBusy = true;

  @override
  bool get isBusy => _isBusy;

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

  DateTime? _date;
  String get date =>
      _date != null ? DateFormat('dd MMM, yyyy').format(_date!) : '';

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
    final List<dynamic> result =
        await _dbService.readAll(obj: budget, table: budgetTableName);
    _budgets = result.cast<Budget>();
    _budgetsToDisplay = getBudgetsToDisplay();
    await Future.delayed(const Duration(milliseconds: 50));
    _isBusy = false;
    notifyListeners();
  }

  List<Budget> getBudgetsToDisplay() {
    return _budgets.length < 5 ? _budgets : _budgets.sublist(0, 5);
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
  void setDate(DateTime value) {
    _date = value;
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
        amount: double.tryParse(_amount.replaceAll(',', '')));
    final result = await runBusyFuture(
        _dbService.create(obj: budget, table: budgetTableName));
    budget = result as Budget;
    _budgets.insert(0, budget);

    // update the budgets to display list
    _budgetsToDisplay = getBudgetsToDisplay();

    /// Navigate back to the budget view.
    navigateBack();

    // set [_date] to an empty string in case of immediate nex entry
    _date = null;

    // set [_categoryValue] to it initial value in case of immediate nex entry
    _categoryValue = _category[0];
    notifyListeners();
  }

  void navigateToCreateBudget(BudgetViewModel model) {
    _navigationService.navigateTo(Routes.createBudgetView,
        arguments: CreateBudgetViewArguments(model: model));
  }

  void navigateBack() {
    _navigationService.popRepeated(1);
  }

  void setState() {
    notifyListeners();
  }

  void gotoBudgetInfoView(Budget budgetsToDisplay) {
    final index = _budgets.indexOf(budgetsToDisplay);
    _navigationService.navigateTo(Routes.budgetInfoView,
        arguments: BudgetInfoViewArguments(budget: _budgets[index]));
  }

  void deleteBudget(Budget budgetToDelete) async {
    final index = _budgets.indexOf(budgetToDelete);
    _budgets.removeAt(index);
    _budgetsToDisplay = getBudgetsToDisplay();
    notifyListeners();

    final result = await _dbService.readAll(
        obj: BudgetExpenses(), table: budgetExpenseTableName);

    // Get all the expenses associated with the budget and save it into [budgetExpenses]
    final List<BudgetExpenses> budgetExpenses = result
        .cast<BudgetExpenses>()
        .where((expenses) => expenses.foreignKey == budgetToDelete.id!)
        .toList();

    // Delete all the expenses associated with the budget from db
    for (var expense in budgetExpenses) {
      _dbService.delete(table: budgetExpenseTableName, id: expense.id!);
    }

    // Delete the budget
    _dbService.delete(table: budgetTableName, id: budgetToDelete.id!);
  }
}

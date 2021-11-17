import 'package:intl/intl.dart';
import '../../../../../app/app.locator.dart';
import '../../../../../app/app.logger.dart';
import '../../../../../app/app.router.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../model/budget_expense_model.dart';
import '../../../../../model/budget_model.dart';
import '../../../../../service/db_service.dart';
import '../../../../../service/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class BudgetInfoViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = NavigationService();
  final _dbService = locator<DataBaseService>();
  double _expensesAmount = 0;
  final log = getLogger('BudgetInfoViewModel');
  bool _showModelBottomSheet = false;
  get showModelBottomSheet => _showModelBottomSheet;
  String _amount = '';
  String get amount => _amount;
  String _description = '';
  String get description => _description;
  String _category = '';
  get category => _category;

  DateTime? _date;
  DateTime get selectedDate => _date!;
  String get date =>
      _date != null ? DateFormat('dd MMM, yyyy').format(_date!) : '';
  List<BudgetExpenses> _expenses = [];
  String get currencySymbol => _userService.currency;
  List<BudgetExpenses> get expenses => _expenses;
  double get balance => _expensesAmount;

  /// This method runs before the widgets in the view loaded and it responsibility is
  /// to get the list of expense related to the budget passed in and also perform some
  /// calculations to get the budget balance
  Future<void> init(Budget budget) async {
    final result = await _dbService.readAll(
        obj: BudgetExpenses(), table: budgetExpenseTableName);
    final List<BudgetExpenses> budgetExpenses = result.cast<BudgetExpenses>();
    log.i(budgetExpenses);
    _expenses = budgetExpenses
        .where((expenses) => expenses.foreignKey == budget.id!)
        .toList();
    log.i('Filtered list of expense $_expenses');
    _expensesAmount = expensesAmount();
    notifyListeners();
  }

  double expensesAmount() {
    double totalAmount = 0;
    for (var expense in _expenses) {
      totalAmount += expense.amount!;
    }
    return totalAmount;
  }

  void goBack() {
    _navigationService.popRepeated(1);
  }

  void updateBudget(Budget budget) async {
    await runBusyFuture(_dbService.update(obj: budget, table: budgetTableName));
  }

  void deleteBudget(Budget budget) async {
    await runBusyFuture(
        _dbService.delete(table: budgetTableName, id: budget.id!));
    goBack();
  }

  void insertBudgetExpenses({required BudgetExpenses expenses}) async {
    final expense = await runBusyFuture(
        _dbService.insert(obj: expenses, table: budgetExpenseTableName));
    _expenses.add(expense);
    _expensesAmount = expensesAmount();
    log.i(_expenses);
    _navigationService.popRepeated(1);
    notifyListeners();
  }

  void deleteBudgetExpenses({required int indexToDelete}) async {
    await runBusyFuture(_dbService.delete(
        id: _expenses[indexToDelete].id!, table: budgetExpenseTableName));
    _expenses.removeAt(indexToDelete);
    _expensesAmount = expensesAmount();
    notifyListeners();
  }

  void gotoAddBudgetExpenses({required model, required budget}) {
    _navigationService.navigateTo(Routes.addBudgetExpensesView,
        arguments:
            AddBudgetExpensesViewArguments(bimodel: model, budget: budget));
  }

  void setDate(DateTime value) {
    _date = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _category = value;
    setShowModelBottomSheet();
    notifyListeners();
  }

  void setShowModelBottomSheet() {
    _showModelBottomSheet = !_showModelBottomSheet;
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
}

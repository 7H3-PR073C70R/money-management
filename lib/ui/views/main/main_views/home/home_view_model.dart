import 'package:money_management/app/app.logger.dart';

import '../../../../../app/app.locator.dart';
import '../../../../../app/app.router.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../model/incomde_and_expenses_model.dart';
import '../../../../../service/db_service.dart';
import '../../../../../service/user_service.dart';
import '../../notes/note_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final _userService = locator<UserService>();
  final _navigationService = NavigationService();
  final log = getLogger('HomeViewModel');

  bool _isFabPressed = false;
  bool _showBottomSheet = false;
  int _selectedFilterIndex = -1;
  bool _isBusy = true;
  double _totalIncome = 0;
  double _totalExpenses = 0;

  List<IncomeAndExpenses> _incomeAndExpenses = [];
  List<IncomeAndExpenses> _filteredIncomeAndExpenses = [];
  @override
  bool get isBusy => _isBusy;

  bool get isFabPressed => _isFabPressed;
  bool get showBottomSheet => _showBottomSheet;
  int get selectedFilterIndex => _selectedFilterIndex;
  double get totalExpenses => _totalExpenses;
  double get totalIncome => _totalIncome;
  double get total => _totalIncome - _totalExpenses;
  String get currencySymbol => _userService.currency;

  List<IncomeAndExpenses> get incomeAndExpenses => _selectedFilterIndex == -1
      ? _incomeAndExpenses
      : _filteredIncomeAndExpenses;
  int get incomeAndExpensesLength => _incomeAndExpenses.length;
  final _dbService = locator<DataBaseService>();

  /// This function runs of startup, it is responsible for fetching the list of notes as
  /// well as the list of income_and_expenses from the db.

  Future<void> init() async {
    log.i(_selectedFilterIndex);
    final incomeAndExpensesResult = await runBusyFuture(_dbService.readAll(
        obj: IncomeAndExpenses(), table: incomeAndExpensesTableName));
    _incomeAndExpenses = incomeAndExpensesResult.cast<IncomeAndExpenses>();
    setExpenseAndIncomeTotal();
    await Future.delayed(const Duration(milliseconds: 50));
    _isBusy = false;
    notifyListeners();
  }

  void updateIncomeOrExpence(IncomeAndExpenses ie, int indexToUpdate) async {
    await runBusyFuture(
        _dbService.update(obj: ie, table: incomeAndExpensesTableName));
    _incomeAndExpenses.removeAt(indexToUpdate);
    _incomeAndExpenses.insert(indexToUpdate, ie);
    notifyListeners();
  }

  void deleteIncomeOrExpence(IncomeAndExpenses ie, int indexToDelete) async {
    _incomeAndExpenses.removeAt(indexToDelete);
    await _dbService.delete(id: ie.id!, table: incomeAndExpensesTableName);

    notifyListeners();
  }

  void setIsFabPressed() {
    _isFabPressed = !_isFabPressed;
    notifyListeners();
  }

  setSelectedFilterIndex(index) {
    _selectedFilterIndex = index;
    _filterIncomeAndExpensesListByDate(index);
    setShowBottomSheet();
    notifyListeners();
  }

  void setShowBottomSheet() {
    _showBottomSheet = !_showBottomSheet;
    notifyListeners();
  }

  void setExpenseAndIncomeTotal() {
    _totalExpenses = 0;
    _totalIncome = 0;
    incomeAndExpenses
        .where((expenses) => expenses.isExpenses == true)
        .toList()
        .forEach((expenses) {
      _totalExpenses += expenses.amount!;
    });

    incomeAndExpenses
        .where((income) => income.isExpenses == false)
        .toList()
        .forEach((income) {
      _totalIncome += income.amount!;
    });
  }

  /// This function filtered the list of income and expenses by date and save
  /// the result into [_filteredIncomeAndExpenses] to update the
  void _filterIncomeAndExpensesListByDate(int index) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final lastWeekStart = now
        .subtract(Duration(days: DateTime.now().weekday))
        .subtract(const Duration(days: 1));
    final lastMonthStart =
        DateTime(now.year, now.month - 1, 1).subtract(const Duration(days: 1));
    _filteredIncomeAndExpenses = _incomeAndExpenses.where((element) {
      final date =
          DateTime(element.date!.year, element.date!.month, element.date!.day);
      switch (index) {
        case 0:
          return date.isAtSameMomentAs(today);
        case 1:
          return date.isAtSameMomentAs(yesterday);
        case 2:
          return date.isAfter(lastWeekStart) && date.isBefore(now);
        case 3:
          return date.isAfter(lastMonthStart) &&
              date.isBefore(lastMonthStart.add(const Duration(days: 32)));
        default:
          return true;
      }
    }).toList();
    setExpenseAndIncomeTotal();
    notifyListeners();
  }

  void navigateToNoteView() {
    _navigationService.navigateTo(Routes.noteView);
  }

  void navigateToAddNoteView() {
    _navigationService.navigateTo(Routes.addNoteView,
        arguments: AddNoteViewArguments(model: NoteViewModel()));
  }
}

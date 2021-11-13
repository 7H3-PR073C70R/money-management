import '../../../../../app/app.locator.dart';
import '../../../../../constants/app_string.dart';
import '../../../../../model/incomde_and_expenses_model.dart';
import '../../../../../service/db_service.dart';
import '../../../../../service/user_service.dart';
import 'package:stacked/stacked.dart';

class ReportViewModel extends BaseViewModel {
  final _dbService = locator<DataBaseService>();
  final _userService = locator<UserService>();

  int _currentPageIndex = 0;
  int _selectedFilterIndex = -1;
  bool _showBottomSheet = false;
  int _incomeTouchIndex = -1;
  int _expensesTouchIndex = -1;
  bool _isBusy = true;

  int get incomeTouchIndex => _incomeTouchIndex;
  int get expensesTouchIndex => _expensesTouchIndex;
  int get currentPageIndex => _currentPageIndex;
  bool get showBottomSheet => _showBottomSheet;
  int get selectedFilterIndex => _selectedFilterIndex;
  String get currencySymbol => _userService.currency;
  @override
  bool get isBusy => _isBusy;
  bool isIncomePieChartTouched(int index) => index == _incomeTouchIndex;
  bool isExpensesPieChartTouched(int index) => index == _expensesTouchIndex;

  List<IncomeAndExpenses> _incomeAndExpenses = [];
  List<IncomeAndExpenses> _filteredIncomeAndExpenses = [];

  List<double> _incomeAmount = [0,0,0,0,0];
  List<double> _expensesAmount = [0,0,0,0,0,0,0,0,];
  List<double> get incomeAmount => _incomeAmount;
  List<double> get expensesAmount => _expensesAmount;
  List<IncomeAndExpenses> get incomeAndExpenses => _selectedFilterIndex == -1
      ? _incomeAndExpenses
      : _filteredIncomeAndExpenses;

  double get incomeTotal {
    double total = 0;
    for (var value in _incomeAmount) {total += value;}
    return total;
  }

  double get expensesTotal {
    double total = 0;
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
    _filterIncomeAndExpensesListByDate(index);
    init();
    setShowBottomSheet();
    notifyListeners();
  }

  Future<void> init() async {
    List<double> incomeAmount = [];
    List<double> expensesAmount = [];
  
    final result = await _dbService.readAll(obj: IncomeAndExpenses(), table: incomeAndExpensesTableName);
    _incomeAndExpenses = result.cast<IncomeAndExpenses>();

    final List<IncomeAndExpenses> income = incomeAndExpenses.where((expenses) => expenses.isExpenses == false).toList();
    final List<IncomeAndExpenses> expenses = incomeAndExpenses.where((income) => income.isExpenses == true).toList();
    double salary = 0;
    double business = 0;
    double investements = 0;
    double cash = 0;
    double other = 0;

    income.where((element) => element.category == 'Salary').toList().forEach((element) {
      salary += element.amount!;
    });

    income.where((element) => element.category == 'Business').toList().forEach((element) {
      business += element.amount!;
    });

    income.where((element) => element.category == 'Investment Return').toList().forEach((element) {
      investements += element.amount!;
    });

    income.where((element) => element.category == 'Cash Gift').toList().forEach((element) {
      cash += element.amount!;
    });

    income.where((element) => element.category == 'Others').toList().forEach((element) {
      cash += element.amount!;
    });
    incomeAmount.add(salary);
    incomeAmount.add(business);
    incomeAmount.add(investements);
    incomeAmount.add(cash);
    incomeAmount.add(other);

    double rent = 0;
    double food = 0;
    double health = 0;
    double data = 0;
    double ent = 0;
    double cloth = 0;
    double electricity = 0;
    double trans = 0;
    double others = 0;
    expenses.where((element) => element.category == 'Rent').toList().forEach((element) {
      rent += element.amount!;
    });
    expenses.where((element) => element.category == 'Food').toList().forEach((element) {
      food += element.amount!;
    });
    expenses.where((element) => element.category == 'Health').toList().forEach((element) {
      health += element.amount!;
    });
    expenses.where((element) => element.category == 'Data').toList().forEach((element) {
      data += element.amount!;
    });
    expenses.where((element) => element.category == 'Entertainment').toList().forEach((element) {
      ent += element.amount!;
    });
    expenses.where((element) => element.category == 'Clothing').toList().forEach((element) {
      cloth += element.amount!;
    });
    expenses.where((element) => element.category == 'Electricity').toList().forEach((element) {
      electricity += element.amount!;
    });
    expenses.where((element) => element.category == 'Transportation').toList().forEach((element) {
      trans += element.amount!;
    });
    expenses.where((element) => element.category == 'Others').toList().forEach((element) {
      others += element.amount!;
    });

    expensesAmount.add(rent);
    expensesAmount.add(food);
    expensesAmount.add(health);
    expensesAmount.add(data);
    expensesAmount.add(ent);
    expensesAmount.add(cloth);
    expensesAmount.add(electricity);
    expensesAmount.add(trans);
    expensesAmount.add(others);

    _expensesAmount = expensesAmount;
    _incomeAmount = incomeAmount;
    await Future.delayed(const Duration(milliseconds: 50));
    _isBusy = false;
    notifyListeners();
  }

  /// This function filtered the list of income and expenses by date and save
  /// the result into [_filteredIncomeAndExpenses] to update the
  void _filterIncomeAndExpensesListByDate(int index,) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1 );
    final lastWeekStart =
        now.subtract(Duration(days: DateTime.now().weekday)).subtract(const Duration(days: 1));
    final lastMonthStart = DateTime(now.year, now.month - 1, 1).subtract(const Duration(days: 1));
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
    notifyListeners();
  }

}

import 'package:money_management/constants/app_string.dart';
import 'package:money_management/model/incomde_and_expenses_model.dart';
import 'package:money_management/service/db_service.dart';
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

  List<double> _incomeAmount = [0,0,0,0,0];
  List<double> _expensesAmount = [0,0,0,0,0,0,0,0,];
  List<double> get incomeAmount => _incomeAmount;
  List<double> get expensesAmount => _expensesAmount;

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
    setShowBottomSheet();
    notifyListeners();
  }

  Future<void> init() async {
    List<double> incomeAmount = [];
    List<double> expensesAmount = [];
  
    final result = await DataBaseService.instance.readAll(obj: IncomeAndExpenses(), table: incomeAndExpensesTableName);
   
    final List<IncomeAndExpenses> incomeAndExpenses = result.cast<IncomeAndExpenses>();
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

    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
  }

}

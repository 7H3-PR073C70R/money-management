import 'package:money_management/app/app.locator.dart';
import 'package:money_management/app/app.logger.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/model/budget_expense_model.dart';
import 'package:money_management/model/budget_model.dart';
import 'package:money_management/model/incomde_and_expenses_model.dart';
import 'package:money_management/model/note_model.dart';
import 'package:money_management/service/db_service.dart';
import 'package:money_management/service/online_db_service.dart';
import 'package:stacked/stacked.dart';

MainViewModel mainViewModel = MainViewModel();

class MainViewModel extends BaseViewModel {
  final _onlineDb = OnlineDbService();
  final _dbService = locator<DataBaseService>();
  final log = getLogger('MainViewModel');



  Future<void> init() async {
    log.i('started');

    //! Fetch data from firebase on login and save it locally.
    await runBusyFuture(_onlineDb.getData());

    log.i('done gettig data from online db');
    
    //! Fetch income and expenses from locally db on setup.
    final incomeAndExpensesResult = await runBusyFuture(_dbService.readAll(
        obj: IncomeAndExpenses(), table: incomeAndExpensesTableName));
    final incomeAndExpenses = incomeAndExpensesResult.cast<IncomeAndExpenses>();


    //! Fetch budget from locally db on setup.
    final List<dynamic> budgetResult =
        await _dbService.readAll(obj: Budget(), table: budgetTableName);
    final budgets  = budgetResult.cast<Budget>();

    //! Fetch note from locally db on setup.
    final noteResult =
        await _dbService.readAll(obj: Note(), table: noteTableName);
    final notes = noteResult.cast<Note>();

    //! Fetch budget expenses from locally db on setup.
    final budgetExpensesResult = await _dbService.readAll(
        obj: BudgetExpenses(), table: budgetExpenseTableName);
    final budgetExpenses = budgetExpensesResult.cast<BudgetExpenses>();

    //! Upload local data to firebase.
    _onlineDb.addIncomeAndExpenses(incomeAndExpenses);
    _onlineDb.addBudgets(budgets);
    _onlineDb.addNotes(notes);
    _onlineDb.addBudgetExpenses(budgetExpenses);

    log.i('done updating data');
    notifyListeners();
  }
  
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  bool _isFabPressed = false;
  bool _showBottomSheet = false;
  int _selectedFilterIndex = 0;
  bool get isFabPressed => _isFabPressed;
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


  void setCurrentPageIndex(int index) {
    _currentPageIndex = index;
    notifyListeners();
  }
}
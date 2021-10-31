import 'package:money_management/constants/app_string.dart';
import 'package:money_management/model/incomde_and_expenses_model.dart';
import 'package:money_management/service/db_service.dart';
import 'package:stacked/stacked.dart';

class AddIncomeOrExpensesViewModel extends BaseViewModel {
  bool _showModelBottomSheet = false;
  get showModelBottomSheet => _showModelBottomSheet;


  String _amount = '';
  String _description = '';

  String _category = '';
  get category => _category;

  String _date = '';
  get date => _date;

  void setDate(String value) {
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

  /// This method call the [DatabaseService] to create a record inside the IncomeAndexpense table.
  void createIncomeOrExpenses(bool isExpenses) async {
   await DataBaseService.instance.create(
        obj: IncomeAndExpenses(
            date: _date,
            amount: double.parse(_amount),
            description: _description,
            category: _category,
            isExpenses: isExpenses),
        table: incomeAndExpensesTableName);
  }
}

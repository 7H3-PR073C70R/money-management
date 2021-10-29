import 'package:stacked/stacked.dart';

class AddIncomeOrExpensesViewModel extends BaseViewModel {
  bool _showModelBottomSheet = false;
  get showModelBottomSheet => _showModelBottomSheet;

  final List<String> _incomeCategory = ['Salary', 'Business', 'Investment Return', 'Cash Gift', 'Others'];
  final List<String> _expensesCategory = ['Rent', 'Food', 'Health', 'Data', 'Entertainment', 'Clothing', 'Electricity', 'Transportation', 'Others'];

  List<String> get incomeCategory => _incomeCategory;
  List<String> get expensesCategory => _expensesCategory;

  String _category = '';
  get category => _category;
  
  String _date = '';
  get date => _date;

  void setDate(String value){
    _date = value;
    notifyListeners();
  }

  void setCategory(String value) {
    _category = value;
    setShowModelBottomSheet();
    notifyListeners();
  }

  void setShowModelBottomSheet(){
    _showModelBottomSheet = !_showModelBottomSheet;
    notifyListeners();
  }
}
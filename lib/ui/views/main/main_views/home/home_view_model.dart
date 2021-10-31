import 'package:intl/intl.dart';
import 'package:money_management/constants/app_string.dart';
import 'package:money_management/model/incomde_and_expenses_model.dart';
import 'package:money_management/model/note_model.dart';
import 'package:money_management/service/db_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  bool _isFabPressed = false;
  bool _showBottomSheet = false;
  bool _showNoteView = false;
  int _selectedFilterIndex = 0;
  double _totalIncome = 0;
  double _totalExpenses = 0;

  List<Note> _notes = [];
  List<IncomeAndExpenses> _incomeAndExpenses = [];


  bool get isFabPressed => _isFabPressed;
  bool get showNoteView => _showNoteView;
  bool get showBottomSheet => _showBottomSheet;
  int get selectedFilterIndex => _selectedFilterIndex;
  double get totalExpenses => _totalExpenses;
  double get totalIncome => _totalIncome;
  double get total => _totalIncome - _totalExpenses;
  List<Note> get notes => _notes;
  List<IncomeAndExpenses> get incomeAndExpenses => _incomeAndExpenses;
  final _db = DataBaseService.instance;


  /// This function runs of startup, it is responsible for fetching the list of notes as
  /// well as the list of income_and_expenses from the db.
  
  Future<void> init() async {
    final noteResult = await _db.readAll(obj: Note(), table: noteTableName);
    final incomeAndExpensesResult = await _db.readAll(obj: IncomeAndExpenses(), table: incomeAndExpensesTableName);
    _notes = noteResult.cast<Note>();
    _incomeAndExpenses = incomeAndExpensesResult.cast<IncomeAndExpenses>();
    setExpenseAndIncomeTotal();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
  }


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

  void setShowNoteView() {
    _showNoteView = !_showNoteView;
    notifyListeners();
  }

  void deleteNote(Note note) async {
    _notes.removeAt(_notes.indexOf(note));
    notifyListeners();
    await _db.delete(table: noteTableName, id: note.id!);
  }

  void createNote(Note note) async {
    final date = DateFormat('d${dateSuffix()} MMM, yyyy  h:mma').format(DateTime.now());
    final addedNote = await _db.create(obj: note.copyWith(date: date), table: noteTableName);
    _notes.insert(0, addedNote);
    notifyListeners();
  }

  void setExpenseAndIncomeTotal() {
    _incomeAndExpenses.where((expenses) => expenses.isExpenses == true).toList().forEach((expenses) { 
      _totalExpenses += expenses.amount!;
    });

    _incomeAndExpenses.where((income) => income.isExpenses == false).toList().forEach((income) {
      _totalIncome += income.amount!;
    });
  }

  String dateSuffix() {
    String date = DateTime.now().day.toString();
    if(date.endsWith('1')) {
      return '\'st\'';
    }
    if(date.endsWith('2')) {
       return '\'nd\'';
    }
    if(date.endsWith('3')) {
      return '\'rd\'';
    }
    return '\'th\'';
  }
}

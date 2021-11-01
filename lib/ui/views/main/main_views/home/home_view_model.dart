import 'package:money_management/constants/app_string.dart';
import 'package:money_management/model/incomde_and_expenses_model.dart';
import 'package:money_management/model/note_model.dart';
import 'package:money_management/service/db_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  bool _showSearchFieldForNote = false;
  bool _isSeachForNoteSearch = false;
  bool _isFabPressed = false;
  bool _showBottomSheet = false;
  bool _showNoteView = false;
  int _selectedFilterIndex = -1;
  bool _isBusy = true;
  double _totalIncome = 0;
  double _totalExpenses = 0;

  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  List<IncomeAndExpenses> _incomeAndExpenses = [];
  List<IncomeAndExpenses> _filteredIncomeAndExpenses = [];
  @override
  bool get isBusy => _isBusy;

  bool get isFabPressed => _isFabPressed;
  bool get showNoteView => _showNoteView;
  bool get showBottomSheet => _showBottomSheet;
  bool get showSearchFieldForNote => _showSearchFieldForNote;
  int get selectedFilterIndex => _selectedFilterIndex;
  double get totalExpenses => _totalExpenses;
  double get totalIncome => _totalIncome;
  double get total => _totalIncome - _totalExpenses;
  List<Note> get notes => _isSeachForNoteSearch ? _filteredNotes : _notes;
  List<IncomeAndExpenses> get incomeAndExpenses => _selectedFilterIndex == -1
      ? _incomeAndExpenses
      : _filteredIncomeAndExpenses;
  final _db = DataBaseService.instance;

  /// This function runs of startup, it is responsible for fetching the list of notes as
  /// well as the list of income_and_expenses from the db.

  Future<void> init() async {
    final noteResult = await _db.readAll(obj: Note(), table: noteTableName);
    final incomeAndExpensesResult = await runBusyFuture(_db.readAll(
        obj: IncomeAndExpenses(), table: incomeAndExpensesTableName));
    _notes = noteResult.cast<Note>();
    _incomeAndExpenses = incomeAndExpensesResult.cast<IncomeAndExpenses>();
    setExpenseAndIncomeTotal();
    await Future.delayed(const Duration(milliseconds: 50));
    _isBusy = false;
    notifyListeners();
  }

  void setIsFabPressed() {
    _isFabPressed = !_isFabPressed;
    notifyListeners();
  }

  void setShowSearchField() {
    _showSearchFieldForNote = !_showSearchFieldForNote;
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

  void setShowNoteView() {
    _showNoteView = !_showNoteView;
    notifyListeners();
  }

  void setNoteQuery(String value) {
    _isSeachForNoteSearch = true;
    _filteredNotes = _notes.where((note) => note.title!.contains(value)).toList();
    notifyListeners();
  }

  void deleteNote(Note note) async {
    _notes.removeAt(_notes.indexOf(note));
    notifyListeners();
    await _db.delete(table: noteTableName, id: note.id!);
  }

  void createNote(Note note) async {
    final addedNote = await _db.create(
        obj: note.copyWith(date: DateTime.now()), table: noteTableName);
    _notes.insert(0, addedNote);
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

  String dateSuffix() {
    String date = DateTime.now().day.toString();
    if (date.endsWith('1')) {
      return '\'st\'';
    }
    if (date.endsWith('2')) {
      return '\'nd\'';
    }
    if (date.endsWith('3')) {
      return '\'rd\'';
    }
    return '\'th\'';
  }

  /// This function filtered the list of income and expenses by date and save
  /// the result into [_filteredIncomeAndExpenses] to update the
  void _filterIncomeAndExpensesListByDate(int index) {
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
    setExpenseAndIncomeTotal();
    notifyListeners();
  }
}

import '../../../../app/app.locator.dart';
import '../../../../app/app.router.dart';
import '../../../../constants/app_string.dart';
import '../../../../model/note_model.dart';
import '../../../../service/db_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class NoteViewModel extends BaseViewModel {
  final _navigationService = NavigationService();
  final _dbService = locator<DataBaseService>();

  bool _showSearchFieldForNote = false;
  bool _isSeachForNoteSearch = false;
  bool _isEditingNote = false;
  List<Note> _notes = [];
  List<Note> _filteredNotes = [];
  bool _isBusy = true;

  @override
  bool get isBusy => _isBusy;

  bool get showSearchFieldForNote => _showSearchFieldForNote;
  bool get isEditingNote => _isEditingNote;
  List<Note> get notes => _isSeachForNoteSearch ? _filteredNotes : _notes;

  void init() async {
    final noteResult =
        await _dbService.readAll(obj: Note(), table: noteTableName);
    _notes = noteResult.cast<Note>();
    _isBusy = false;
    notifyListeners();
  }

  void setShowSearchField() {
    _showSearchFieldForNote = !_showSearchFieldForNote;
    notifyListeners();
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

  void setNoteQuery(String value) {
    _isSeachForNoteSearch = true;
    _filteredNotes =
        _notes.where((note) => note.title!.contains(value)).toList();
    notifyListeners();
  }

  void setIsEditing(bool value) {
    _isEditingNote = value;
    notifyListeners();
  }

  void deleteNote(Note note, [bool isFromReadNote = false]) async {
    _notes.removeAt(_notes.indexOf(note));
    notifyListeners();
    await _dbService.delete(table: noteTableName, id: note.id!);
    if(isFromReadNote) {
      navigateBack();
    }
  }

  void createNote(Note note) async {
    final addedNote = await _dbService.insert(
        obj: note.copyWith(date: DateTime.now()), table: noteTableName);
    _notes.insert(0, addedNote);
    notifyListeners();
    navigateBack();
  }

  void updateNote(int noteIndex, Note note) async {
    await _dbService.update(
        obj: note.copyWith(date: DateTime.now()), table: noteTableName);
        _notes.removeAt(noteIndex);
    _notes.insert(noteIndex, note);
    notifyListeners();
  }

  void navigateToAddNoteView(NoteViewModel model) {
    _navigationService.navigateTo(Routes.addNoteView,
        arguments: AddNoteViewArguments(model: model));
  }

  void naviateToViewNote({required Note selectedNote, required int index, required NoteViewModel model}) {
    _navigationService.navigateTo(Routes.readNoteView,
        arguments: ReadNoteViewArguments(note: selectedNote, noteIndex: index, model: model));
  }

  void navigateBack() {
    _navigationService.popRepeated(1);
  }
}

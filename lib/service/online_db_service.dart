import 'package:cloud_firestore/cloud_firestore.dart';
import '../app/app.locator.dart';
import '../app/app.logger.dart';
import '../constants/app_string.dart';
import '../model/budget_expense_model.dart';
import '../model/budget_model.dart';
import '../model/incomde_and_expenses_model.dart';
import '../model/note_model.dart';
import '../model/user_model.dart';
import 'db_service.dart';
import 'user_service.dart';

import 'auth_service.dart';

class OnlineDbService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _dbService = locator<DataBaseService>();
  final _authService = AuthService();
  final String _incomeAndExpensesBucket = 'Income and Expenses';
  final String _budgetsBucket = 'Budgets';
  final String _notesBucket = 'Notes';
  final String _budgetExpensesBucket = 'Budget Expenses';
  final log = getLogger('OnlineDbService');
  final String uid = UserService().user.id ?? '';
  CollectionReference get _mainCollection =>
      _firestore.collection('My Money Manager');

  Future<void> _addList(List<dynamic> list, String bucket) async {
    if (list.isEmpty) {
      return;
    }
    try {
      DocumentReference documentReferencer =
          _mainCollection.doc(uid).collection(bucket).doc(uid);
      final List<Map<String, dynamic>> listOfObjMaps = [];
      for (var obj in list) {
        listOfObjMaps.add(obj.toJson());
      }
      documentReferencer.set({bucket: listOfObjMaps});
    } catch (e) {
      log.i(e);
    }
  }

  Future<void> _getAllData(
      {required String bucket,
      required dynamic obj,
      required String tableName}) async {
    try {
      final result =
          _mainCollection.doc(uid).collection(bucket).doc(uid).snapshots();
      result.first.then((value) {
        try {
          List result = value.get(bucket).toList();
          for (var value in result) {
            final objToSave = obj.fromJson(value);
            log.i(objToSave);
            _dbService.insert(obj: objToSave, table: tableName);
          }
        } catch (e) {
          log.i(e);
        }
      });
    } catch (e) {
      log.i(e);
    }
  }

  void addIncomeAndExpenses(List<IncomeAndExpenses> incomeAndExpense) {
    _addList(incomeAndExpense, _incomeAndExpensesBucket);
  }

  void addBudgets(List<Budget> budgets) {
    _addList(budgets, _budgetsBucket);
  }

  void addNotes(List<Note> notes) {
    _addList(notes, _notesBucket);
  }

  void addBudgetExpenses(List<BudgetExpenses> budgetExpenses) {
    _addList(budgetExpenses, _budgetExpensesBucket);
  }

  Future<void> getAllIncomeAndExpenses() async {
    await _getAllData(
        bucket: _incomeAndExpensesBucket,
        obj: IncomeAndExpenses(),
        tableName: incomeAndExpensesTableName);
  }

  Future<void> getAllBudgets() async {
    await _getAllData(
        bucket: _budgetExpensesBucket,
        obj: Budget(),
        tableName: budgetTableName);
  }

  Future<void> getAllNotes() async {
    await _getAllData(
        bucket: _notesBucket, obj: Note(), tableName: noteTableName);
  }

  Future<void> getAllBudgetExpenses() async {
    await _getAllData(
        bucket: _budgetExpensesBucket,
        obj: BudgetExpenses(),
        tableName: budgetExpenseTableName);
  }

  Future<void> getData() async {
    await getAllIncomeAndExpenses();
    await getAllBudgetExpenses();
    await getAllBudgets();
    await getAllNotes();
  }

  Future<void> updateUserInfo(User user) async {
    await _firestore.collection('users').doc(uid).update(user.toJson());
    if (user.email != null && user.email!.isNotEmpty) {
      try {
        _authService.updateEmail(user.email!);
      } catch (e) {
        rethrow;
      }
    }
  }
}

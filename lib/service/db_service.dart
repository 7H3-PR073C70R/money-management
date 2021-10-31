import 'package:money_management/constants/app_string.dart';
import 'package:money_management/model/budget_model.dart';
import 'package:money_management/model/incomde_and_expenses_model.dart';
import 'package:money_management/model/note_model.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseService {
  static final DataBaseService instance = DataBaseService._init();
  static Database? _database;
  DataBaseService._init();

  /// This method tries to get the databse, if it already exist then it just return the
  /// database else it call the [_initDB] method to initialize the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB(dbName);
    return _database!;
  }

  /// Db initializzation method.
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = dbPath + filePath;

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  /// This method is called if there's no db created yet. The work of this method is
  /// to create the tables the datas will be stored to.
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const boolType = 'BOOLEAN NOT NULL';
    const textType = 'TEXT NOT NULL';
    const numType = 'REAL NOT NULL';

    /// Create Table Budget inside the database.
    await db.execute(
        'CREATE TABLE $budgetTableName (${BudgetField.id} $idType,  ${BudgetField.amount} $numType, ${BudgetField.category} $textType, ${BudgetField.description} $textType, ${BudgetField.date} $textType)');

    /// Create Table IncomeAndExpense inside the database. Use the boolean value [isExpenses]
    /// to know if the saved data is an income data or an expenses data. This is done this way
    /// because they both save exactly the same value to the db and also the boolean is used
    /// to change the color of the text in the home page.
    await db.execute(
        'CREATE TABLE $incomeAndExpensesTableName (${IncomeAndExpensesField.id} $idType,  ${IncomeAndExpensesField.amount} $numType, ${IncomeAndExpensesField.category} $textType, ${IncomeAndExpensesField.description} $textType, ${IncomeAndExpensesField.date} $textType, ${IncomeAndExpensesField.isExpenses} $boolType )');

    /// Create Table Note
    await db.execute(
        'CREATE TABLE $noteTableName (${NoteField.id} $idType, ${NoteField.title} $textType, ${NoteField.text} $textType, ${NoteField.date} $textType)');
  }

  /// This method is responsible for inserting data into the db, the method required the obj
  /// you want to save as well as the table the data is to be saved in. The obj of the
  /// data you want to save is needed as the method is save generic data to the db and
  /// also the the toJson method to method well.
  Future<dynamic> create({required dynamic obj, required String table}) async {
    final db = await instance.database;
    final id = await db.insert(table, obj.toJson());
    return obj.copyWith(id: id);
  }

  /// This method read that from local storage, the only reason the method is requesting
  /// for an obj to is the method can make use of the obj from json method to convert the
  /// database json value to an obj of that class. This is done this way for easy access.
  Future<dynamic> read({
    required String table,
    required int id,
    required dynamic obj,
  }) async {
    final db = await instance.database;
    final result = await db
        .query(table, columns: obj.columns, where: '_id = ?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return obj.fromJson(result.first);
    } else {
      throw Exception('Invalid ID');
    }
  }

  /// This method return all the datas in a given table. The obj is needed to make the
  /// use of the member class [fromJson] possible.
  Future<List<dynamic>> readAll(
      {required dynamic obj, required String table}) async {
    final db = await instance.database;
    const orderBy = 'date DESC';
    final result = await db.query(table, orderBy: orderBy);
    return result.map((json) => obj.fromJson(json)).toList();
  }

  /// This method update a record in the db.
  Future<int> update({required dynamic obj, required String table}) async {
    final db = await instance.database;
    return db
        .update(table, obj.toJson(), where: '_id = ?', whereArgs: [obj.id]);
  }

  /// This method delete a record from a the given table using the supplied id.
  Future<int> delete({
    required String table,
    required int id,
  }) async {
    final db = await instance.database;
    return await db.delete(table, where: '_id = ?', whereArgs: [id]);
  }

  /// This method close the db
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}

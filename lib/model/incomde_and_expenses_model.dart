class IncomeAndExpensesField {
  static const id = '_id';
  static const amount = 'amount';
  static const category = 'category';
  static const date = 'date';
  static const isExpenses = 'isExpenses';
  static const description = 'description';
}

class IncomeAndExpenses {
  int? id;
  double? amount;
  String? category;
  DateTime? date;
  String? description;
  bool? isExpenses;

  IncomeAndExpenses(
      {
      this.id,
      this.amount,
      this.category,
      this.date,
      this.description,
      this.isExpenses = false});

  IncomeAndExpenses copyWith({
    int? id,
    double? amount,
    String? category,
    DateTime? date,
    String? description,
    bool? isExpenses,
  }) {
    return IncomeAndExpenses(
      id: id ?? this.id,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        date: date ?? this.date,
        isExpenses: isExpenses ?? this.isExpenses,
        description: description ?? this.description);
  }

  IncomeAndExpenses fromJson(Map<String, dynamic> json) =>
     IncomeAndExpenses(
       id: json[IncomeAndExpensesField.id],
      amount: json[IncomeAndExpensesField.amount],
      category: json[IncomeAndExpensesField.category],
      date: DateTime.tryParse(json[IncomeAndExpensesField.date]),
      description: json[IncomeAndExpensesField.description],
      isExpenses: json[IncomeAndExpensesField.isExpenses]  == 1 ? true : false
    );
  

  Map<String, dynamic> toJson() => {
    IncomeAndExpensesField.id: id,
    IncomeAndExpensesField.amount: amount,
    IncomeAndExpensesField.category: category,
    IncomeAndExpensesField.date: date!.toIso8601String(),
    IncomeAndExpensesField.description: description,
    IncomeAndExpensesField.isExpenses: isExpenses! ? 1 : 0
  };

  static final instance = IncomeAndExpenses();
  final List<String> columns = [IncomeAndExpensesField.id, IncomeAndExpensesField.amount, IncomeAndExpensesField.category, IncomeAndExpensesField.description, IncomeAndExpensesField.date, IncomeAndExpensesField.isExpenses];
}

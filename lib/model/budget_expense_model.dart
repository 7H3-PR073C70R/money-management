class BudgetExpensesField {
  static const id = '_id';
  static const amount = 'amount';
  static const category = 'category';
  static const date = 'date';
  static const description = 'description';
  static const foreignKey = 'foreignKey';
}

class BudgetExpenses {
  int? id;
  double? amount;
  String? category;
  DateTime? date;
  String? description;
  int? foreignKey;

  BudgetExpenses(
      {this.id,
      this.amount,
      this.category,
      this.date,
      this.description,
      this.foreignKey});

  BudgetExpenses copyWith({
    int? id,
    double? amount,
    String? category,
    DateTime? date,
    String? description,
    int? foreignKey,
  }) {
    return BudgetExpenses(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        date: date ?? this.date,
        foreignKey: foreignKey ?? this.foreignKey,
        description: description ?? this.description);
  }

  BudgetExpenses fromJson(Map<String, dynamic> json) => BudgetExpenses(
        id: json[BudgetExpensesField.id],
        amount: json[BudgetExpensesField.amount],
        category: json[BudgetExpensesField.category],
        date: DateTime.tryParse(json[BudgetExpensesField.date]),
        description: json[BudgetExpensesField.description],
        foreignKey: json[BudgetExpensesField.foreignKey],
      );

  Map<String, dynamic> toJson() => {
        BudgetExpensesField.id: id,
        BudgetExpensesField.amount: amount,
        BudgetExpensesField.category: category,
        BudgetExpensesField.date: date!.toIso8601String(),
        BudgetExpensesField.description: description,
        BudgetExpensesField.foreignKey: foreignKey
      };

  final List<String> columns = [
    BudgetExpensesField.id,
    BudgetExpensesField.amount,
    BudgetExpensesField.category,
    BudgetExpensesField.description,
    BudgetExpensesField.date,
    BudgetExpensesField.foreignKey
  ];
}

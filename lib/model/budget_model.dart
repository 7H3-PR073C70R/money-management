class BudgetField {
  static const id = '_id';
  static const amount = 'amount';
  static const category = 'category';
  static const date = 'date';
  static const description = 'description';
}

class Budget {
  int? id;
  double? amount;
  String? category;
  String? date;
  String? description;

  Budget(
      {
      this.id,
      this.amount = 0,
      this.category = 'Health',
      this.date = 'unkonow',
      this.description = 'fuck off'});

  Budget copyWith({
    int? id,
    double? amount,
    String? category,
    String? date,
    String? description,
  }) {
    return Budget(
      id: id ?? this.id,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        date: date ?? this.date,
        description: description ?? this.description);
  }

  Budget fromJson(Map<String, dynamic> json) =>
     Budget(
       id: json[BudgetField.id],
      amount: json[BudgetField.amount],
      category: json[BudgetField.category],
      date: json[BudgetField.date],
      description: json[BudgetField.description]
    );
  

  Map<String, dynamic> toJson() => {
    BudgetField.id: id,
    BudgetField.amount: amount,
    BudgetField.category: category,
    BudgetField.date: date,
    BudgetField.description: description
  };

  final List<String> columns = [BudgetField.id, BudgetField.amount, BudgetField.category, BudgetField.description, BudgetField.date];
}

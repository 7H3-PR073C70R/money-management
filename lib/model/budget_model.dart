class Budget {
  int? amount;
  String? category;
  String? date;
  String? description;

  Budget(
      {this.amount = 0,
      this.category = '',
      this.date = '',
      this.description = ''});

  Budget copyWith({
    int? amount,
    String? category,
    String? date,
    String? description,
  }) {
    return Budget(
        amount: amount ?? this.amount,
        category: category ?? this.category,
        date: date ?? this.date,
        description: description ?? this.description);
  }

  Budget fromJson(Map<String, dynamic> json) =>
     Budget(
      amount: json['amount'],
      category: json['category'],
      date: json['date'],
      description: json['description']
    );
  

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'category': category,
    'date': date,
    'description': description
  };
}

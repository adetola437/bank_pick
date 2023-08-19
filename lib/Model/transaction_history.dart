class TransactionHistory {
  String name;
  String email;
  num amount;
  String description;
  DateTime? transactionTime;
  String? type;

  TransactionHistory(
      {this.type = 'debit',
      required this.amount,
      required this.description,
      required this.email,
      required this.transactionTime,
      required this.name});

  factory TransactionHistory.fromJson(Map<String, dynamic> json) {
    return TransactionHistory(
         transactionTime: DateTime.parse(json['transactionTime']),
        amount: json['amount'],
        description: json['description'],
        email: json['email'],
        type: json['type'],
        name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'description': description,
      'email': email,
      'name': name,
      'transactionTime': transactionTime!.toIso8601String(),
      'type': type
    };
  }
}

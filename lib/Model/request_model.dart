import 'package:equatable/equatable.dart';

class RequestModel extends Equatable {
  String email;
  String name;
  String description;
  DateTime time;
  String status;
  num amount;

  RequestModel(
      {required this.email,
      required this.amount,
      required this.description,
      required this.name,
      required this.time,
      required this.status});

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
        amount: json['amount'] as num,
        email: json['email'] as String,
        description: json['description'] as String,
        name: json['name'] as String,
        time: DateTime.parse(json['time']),
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'description': description,
      'name': name,
      'time': time.toIso8601String(),
      'status': status,
      'amount': amount
    };
  }

  @override
  List<Object?> get props => [email, name, description, status, amount, time];
}

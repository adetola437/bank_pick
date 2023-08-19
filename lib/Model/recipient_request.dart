enum RequestStateEnum { loading, success,error }

class RecipientRequest {
  String email;
  String name;
  String description;
  DateTime time;
  String status;
  num amount;
  String requestId;
  String senderUid;
  RequestStateEnum requestState;

  RecipientRequest({
    required this.email,
    required this.amount,
    required this.description,
    required this.name,
    required this.time,
    required this.status,
    required this.requestId,
    required this.senderUid,
    this.requestState = RequestStateEnum.success,
  });

  factory RecipientRequest.fromJson(Map<String, dynamic> json) {
    return RecipientRequest(
        senderUid: json['senderUid'],
        amount: json['amount'] as num,
        email: json['email'] as String,
        description: json['description'] as String,
        name: json['name'] as String,
        requestId: json['requestId'],
        time: DateTime.parse(json['time']),
        status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid,
      'requestId': requestId,
      'email': email,
      'description': description,
      'name': name,
      'time': time.toIso8601String(),
      'status': status,
      'amount': amount
    };
  }
}

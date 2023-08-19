class User {
  String name;
  String phoneNumber;
  String email;
  num balance;
  String? uid;
  num? pin;
  String? token;

  User(
      {required this.token,
        required this.email,
      required this.name,
      required this.uid,
      required this.phoneNumber,
      this.balance = 0,
      this.pin = 0});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      token: json['token'],
        pin: json['pin'] ?? 0,
        uid: json['uid'],
        email: json['email'],
        balance: json['balance'] ?? 0,
        name: json['name'],
        phoneNumber: json['Phone Number']);
  }
  Map<String, dynamic> toJson() {
    return {
      'token':token,
      'pin': pin,
      'email': email,
      'Phone Number': phoneNumber,
      'name': name,
      'balance': balance,
      'uid': uid
    };
  }
}

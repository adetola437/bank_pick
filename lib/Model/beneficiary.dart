class Beneficiary {
  String email;
  String name;
  String initials;

  Beneficiary(
      {required this.email, required this.initials, required this.name});

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(email: json['email'], initials: json['initials'], name:json['name'] );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'initials': initials, 'name': name};
  }
}

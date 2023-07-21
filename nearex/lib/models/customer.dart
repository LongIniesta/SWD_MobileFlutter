class Customer {
  final int id;
  final String? email;
  final String? password;
  final String? userName;
  String? phone;
  String? gender;
  DateTime? dateOfBirth;
  String? address;
  String? avatar;
  String? fcmToken;
  String? verificationToken;
  DateTime? verifiedAt;
  String? passwordResetToken;
  DateTime? resetTokenExpires;
  final String token;

  Customer(
      {required this.id,
      required this.email,
      required this.password,
      required this.userName,
      required this.phone,
      required this.gender,
      required this.dateOfBirth,
      required this.address,
      required this.avatar,
      required this.fcmToken,
      required this.verificationToken,
      required this.verifiedAt,
      required this.passwordResetToken,
      required this.resetTokenExpires,
      required this.token});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        email: json['email'],
        password: json['password'],
        userName: json['userName'],
        phone: json['phone'],
        gender: json['gender'],
        dateOfBirth: DateTime.parse(json['dateOfBirth']),
        address: json['address'],
        avatar: json['avatar'],
        fcmToken: json['fcmtoken'],
        verificationToken: json['verificationToken'],
        verifiedAt: json['verifiedAt'],
        passwordResetToken: json['passwordResetToken'],
        resetTokenExpires: json['resetTokenExpires'],
        token: json['token']);
  }
}

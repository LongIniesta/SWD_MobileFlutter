class Customer {
  int? id;
  String? email;
  String? passwordHash;
  String? passwordSalt;
  String? userName;
  String? phone;
  String? gender;
  DateTime? dateOfBirth;
  String? address;
  String? avatar;
  String? googleId;
  String? fcmtoken;
  String? verificationToken;
  String? verifiedAt;
  String? token;
  String? coordinateString;
  String? wishList;

  Customer(
      {this.id,
      this.email,
      this.passwordHash,
      this.passwordSalt,
      this.userName,
      this.phone,
      this.gender,
      this.dateOfBirth,
      this.address,
      this.avatar,
      this.googleId,
      this.fcmtoken,
      this.verificationToken,
      this.verifiedAt,
      this.token,
      this.coordinateString,
      this.wishList});

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
        id: json['id'],
        email: json['email'],
        passwordHash: json['passwordHash'],
        passwordSalt: json['passwordSalt'],
        userName: json['userName'],
        phone: json['phone'],
        gender: json['gender'],
        dateOfBirth: DateTime.parse(json['dateOfBirth']),
        address: json['address'],
        avatar: json['avatar'],
        googleId: json['googleId'],
        fcmtoken: json['fcmtoken'],
        verificationToken: json['verificationToken'],
        verifiedAt: json['verifiedAt'],
        token: json['token'],
        coordinateString: json['coordinateString']);
  }
}

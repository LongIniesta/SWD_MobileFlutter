import 'dart:convert';

class Store {
  
  final int? id;
  final String? storeName;
  final String? phone;
  final String? address;
  final String? logo;
  final String? token;
  final String? coordinateString;

  Store({required this.id, required this.storeName, required this.phone, required this.address, required this.logo, required this.token, required this.coordinateString});
  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      storeName: json['storeName'],
      phone: json['phone'],
      address: json['address'],
      logo: json['logo'],
      token: json['token'],
      coordinateString: json['coordinateString']
    );
  }
}
Store parseJson(String jsonString) {
  final jsonData = json.decode(jsonString);
  return Store.fromJson(jsonData);
}
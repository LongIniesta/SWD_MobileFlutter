import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/customer.dart';
import 'package:nearex/utils/data_storage.dart';

class CustomerService {
  // gán giá trị tạm thời để tiện test các chức năng khác
  static Customer? customer = Customer.fromJson(<String, dynamic>{
    "id": 9,
    "email": "lyngo1294@gmail.com",
    "passwordHash":
        "FuHtmgkZd/K5eShRC9tPUy4QvDKF3e3IQ/UARiJ4SVY8K03ENl+5jMFbJNz0XlDNqFQxDf6EiCkiyideM787hQ==",
    "passwordSalt":
        "nn1f+0BoMKVivXl17c1RolIpVvjB88UMiq1E2xm/L0XFWP7Uc/feiUh5Vr3UeUnFlm7nN9wMe8AFO5dp10IGPHxWCFqwCRIHI2T5hOTHtVS1HcXzqyNq4zCmd6WEkGpwqFzpAd7/Ks0t3kp6Pep9KC5toYJUFSYrw13k47fpnf4=",
    "userName": "Ly",
    "phone": "0971186467",
    "gender": "",
    "dateOfBirth": "2000-09-15T08:36:24.983",
    "address": "",
    "avatar": "",
    "googleId": "",
    "fcmtoken": null,
    "verificationToken": null,
    "verifiedAt": null,
    "token":
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiI5Iiwicm9sZSI6ImN1c3RvbWVyIiwidW5pcXVlX25hbWUiOiJMeSIsImVtYWlsIjoibHluZ28xMjk0QGdtYWlsLmNvbSIsIkZjbVRva2VuIjoiIiwiSW1hZ2VVcmwiOiIiLCJHb29nbGVJZCI6IiIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL21vYmlsZXBob25lIjoiMDk3MTE4NjQ2NyIsIm5iZiI6MTY4OTY4Nzc5NCwiZXhwIjoxNzIxMzEwMTk0LCJpYXQiOjE2ODk2ODc3OTR9.96RS7Ncc--_-bul8whJCTVn-Y9F0DecrNV9XS4zlW5I",
    "coordinateString": "",
    "wishList": null
  });

  static Future<Customer?> verification(
      {String? phone, String? googleId}) async {
    Customer? customer;
    Map<String, dynamic> parameters = {'phone': phone, 'googleId': googleId};
    Uri uri = Uri.https(
        'swd-nearex.azurewebsites.net', '/api/user/verification', parameters);
    Map<String, dynamic> body = {
      "accountSID": "",
      "authToken": "",
      "pathServiceSid": "",
      "phone": "",
      "token": null
    };
    return customer;
  }

  static Future<Customer?> login(String phone, String password) async {
    Customer? customer;
    Uri uri = Uri.parse(
        'https://swd-nearex.azurewebsites.net/api/users/authentication');
    Map<String, dynamic> body = {'phone': phone, 'password': password};
    Response response = await post(uri, body: jsonEncode(body));
    if (response.statusCode == 200) {
      customer = Customer.fromJson(jsonDecode(response.body));
      CustomerService.customer = customer;
    }
    return customer;
  }

  static Future<Customer?> getCustomerByCustomerId(int customerId) async {
    Customer? customer;
    Uri uri =
        Uri.parse('https://swd-nearex.azurewebsites.net/api/users/$customerId');
    final authorizedToken =
        await DataStorage.secureStorage.read(key: 'customerJwt');
    Map<String, String> headers = {'Authorization': 'Bearer $authorizedToken'};
    Response response = await post(uri, headers: headers);
    if (response.statusCode == 200) {
      customer = Customer.fromJson(jsonDecode(response.body));
    }
    return customer;
  }

  static Future<Customer?> updateCustomer(
      {required int customerId,
      String? email,
      String? password,
      String? userName,
      String? phone,
      String? gender,
      DateTime? dateOfBirth,
      String? address,
      String? avatar}) async {
    Customer? customer = await getCustomerByCustomerId(customerId);
    if (customer == null) {
      return null;
    }
    Uri uri =
        Uri.parse('https://swd-nearex.azurewebsites.net/api/users/$customerId');
    Map<String, dynamic> body = {
      "email": email ?? customer.email,
      "password": password ?? customer.password,
      "passwordHash": "",
      "passwordSalt": "",
      "userName": userName ?? customer.userName,
      "phone": phone ?? customer.phone,
      "gender": gender ?? customer.gender,
      "dateOfBirth": dateOfBirth ?? customer.dateOfBirth,
      "address": address ?? customer.address,
      "avatar": avatar ?? customer.avatar,
      "coordinateString": "",
      "wishList": 0
    };
    final authorizedToken =
        await DataStorage.secureStorage.read(key: 'customerJwt');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authorizedToken'
    };
    Response response =
        await put(uri, headers: headers, body: jsonEncode(body));
    if (response.statusCode == 200) {}
    return customer;
  }
}

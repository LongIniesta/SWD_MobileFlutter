import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/customer.dart';
import 'package:nearex/utils/data_storage.dart';

class CustomerService {
  static Customer? _customer;
  static Future<Customer?> getCustomerByCustomerId(int customerId) async {
    Customer? customer;
    Uri uri =
        Uri.parse('https://swd-nearex.azurewebsites.net/api/users/$customerId');
    final authorizedToken =
        await DataStorage.secureStorage.read(key: 'customerJwt');
    Map<String, String> headers = {'Authorization': 'Bearer $authorizedToken'};
    Response response = await post(uri, headers: headers);
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

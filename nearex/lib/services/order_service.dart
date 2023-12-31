import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/order.dart';

class OrderService {
  static Future<List<Order>> getOrders(
      {int? page,
      int? pageSize,
      int? customerId,
      DateTime? orderDate,
      int? status,
      int? quantity,
      int? campaignId}) async {
    List<Order> orders = [];
    Map<String, String> parameters = {};
    if (page != null) parameters['Page'] = page.toString();
    if (pageSize != null) parameters['PageSize'] = pageSize.toString();
    if (orderDate != null) parameters['OrderDate'] = orderDate.toString();
    if (status != null) parameters['Status'] = status.toString();
    if (quantity != null) parameters['Quantity'] = quantity.toString();
    if (campaignId != null) parameters['CampaignId'] = campaignId.toString();
    if (customerId != null) parameters['CustomerId'] = customerId.toString();

    Uri uri =
        Uri.https('swd-nearex.azurewebsites.net', '/api/orders', parameters);
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${customer?.token}'
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwicm9sZSI6ImN1c3RvbWVyIiwidW5pcXVlX25hbWUiOiJUcuG6p24gVGjhu4sgSG_DoG5nIEFuaCIsImVtYWlsIjoiaG9hbmdhbmh0cmFudGhpMTYxMEBnbWFpbC5jb20iLCJGY21Ub2tlbiI6IiIsIkltYWdlVXJsIjoiYW5oYW5oIiwiR29vZ2xlSWQiOiIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6IjA5Njg3NTI3OTkiLCJuYmYiOjE2ODkxNzc2NTcsImV4cCI6MTcyMDgwMDA1NywiaWF0IjoxNjg5MTc3NjU3fQ.ACGYH4k9gzmlc_5ooc4EmJ-a3hNkmGW_SMUnUAExmg8'
    };
    Response response = await get(uri);
    if (response.statusCode == 200) {
      var ordersJson = jsonDecode(response.body)['results'];
      for (final orderJson in ordersJson) {
        orders.add(Order.fromJson(orderJson));
      }
    }
    return orders;
  }

  static Future<Order?> saveOrder(
      {required int quantity,
      required int campaignId,
      required int customerId,
      required String paymentMethod,
      DateTime? paymentTime}) async {
    Order? order;
    Uri uri = Uri.parse('https://swd-nearex.azurewebsites.net/api/orders');
    var body = jsonEncode(<String, dynamic>{
      "orderDate": DateTime.now().toIso8601String(),
      "quantity": quantity,
      "campaignId": campaignId,
      "customerId": customerId,
      "paymentRequest": {
        "method": paymentMethod,
        "time": paymentTime ?? DateTime.now().toIso8601String()
      }
    });
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${customer?.token}'
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCIsImN0eSI6IkpXVCJ9.eyJuYW1laWQiOiIxIiwicm9sZSI6ImN1c3RvbWVyIiwidW5pcXVlX25hbWUiOiJUcuG6p24gVGjhu4sgSG_DoG5nIEFuaCIsImVtYWlsIjoiaG9hbmdhbmh0cmFudGhpMTYxMEBnbWFpbC5jb20iLCJGY21Ub2tlbiI6IiIsIkltYWdlVXJsIjoiYW5oYW5oIiwiR29vZ2xlSWQiOiIiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6IjA5Njg3NTI3OTkiLCJuYmYiOjE2ODkxNzc2NTcsImV4cCI6MTcyMDgwMDA1NywiaWF0IjoxNjg5MTc3NjU3fQ.ACGYH4k9gzmlc_5ooc4EmJ-a3hNkmGW_SMUnUAExmg8'
    };

    Response response = await post(uri, body: body, headers: headers);
    if (response.statusCode == 200) {
      order = Order.fromJson(jsonDecode(response.body));
    }
    return order;
  }
}

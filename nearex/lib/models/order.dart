import 'package:nearex/services/customer_service.dart';

class Order {
  int? id;
  DateTime orderDate;
  int status;
  int quantity;
  int campaignId;
  int? customerId;
  String? productName;
  int? unitPrice;
  String? productImg;
  String? storeName;
  PaymentRequest? paymentRequest;
  PaymentResponse? paymentResponse;
  Order(
      {this.id,
      required this.orderDate,
      required this.status,
      required this.quantity,
      required this.campaignId,
      this.paymentRequest,
      this.paymentResponse,
      this.customerId,
      this.productImg,
      this.productName,
      this.storeName,
      this.unitPrice});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        orderDate: DateTime.parse(json['orderDate']),
        status: json['status'],
        quantity: json['quantity'],
        campaignId: json['campaignId'],
        paymentRequest: json.containsKey('paymentRequest')
            ? PaymentRequest.fromJson(json['paymentRequest'])
            : null,
        paymentResponse: json.containsKey('payments')
            ? PaymentResponse.fromJson(json['payments'])
            : null,
        customerId: CustomerService.customer?.id,
        productImg: json['productImg'],
        productName: json['productName'],
        storeName: json['storeName'],
        unitPrice: json['unitPrice']);
  }
}

class PaymentRequest {
  String paymentMethod;
  DateTime paymentTime;
  PaymentRequest({required this.paymentMethod, required this.paymentTime});
  factory PaymentRequest.fromJson(Map<String, dynamic> json) {
    return PaymentRequest(
        paymentMethod: json['paymentMethod'],
        paymentTime: DateTime.parse(json['paymentTime']));
  }
}

class PaymentResponse {
  int id;
  String method;
  int status;
  DateTime time;
  PaymentResponse(
      {required this.id,
      required this.method,
      required this.status,
      required this.time});
  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
        id: json['id'],
        method: json['method'],
        status: json['status'],
        time: json['time']);
  }
}

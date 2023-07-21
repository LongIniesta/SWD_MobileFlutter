class Order {
  int? id;
  DateTime orderDate;
  DateTime? shippedDate;
  int status;
  int quantity;
  int campaignId;
  PaymentRequest? paymentRequest;
  PaymentResponse? paymentResponse;
  // "productName": "string",
  // "unitPrice": 0,
  // "productImg": "string",
  // "storeName": "string",
  Order(
      {this.id,
      required this.orderDate,
      this.shippedDate,
      required this.status,
      required this.quantity,
      required this.campaignId,
      this.paymentRequest,
      this.paymentResponse});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        orderDate: json['orderDate'],
        shippedDate: json['shippedDate'],
        status: json['status'],
        quantity: json['quantity'],
        campaignId: json['campaignId'],
        paymentRequest: json.containsKey('paymentRequest')
            ? PaymentRequest.fromJson(json['paymentRequest'])
            : null,
        paymentResponse: json.containsKey('payments')
            ? PaymentResponse.fromJson(json['payments'])
            : null);
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

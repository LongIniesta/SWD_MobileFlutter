class Order {
  int id;
  DateTime orderDate;
  DateTime shippedDate;
  int status;
  int quantity;
  int campaignId;
  // "productName": "string",
  // "unitPrice": 0,
  // "productImg": "string",
  // "storeName": "string",
  // "payments": [
  //   {
  //     "id": 0,
  //     "method": "string",
  //     "status": 0,
  //     "time": "2023-06-29T06:25:44.136Z",
  //     "orderId": 0
  //   }
  // ]
  Order(
      {required this.id,
      required this.orderDate,
      required this.shippedDate,
      required this.status,
      required this.quantity,
      required this.campaignId});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        id: json['id'],
        orderDate: json['orderDate'],
        shippedDate: json['shippedDate'],
        status: json['status'],
        quantity: json['quantity'],
        campaignId: json['campaignId']);
  }
}

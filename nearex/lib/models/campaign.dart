import 'package:nearex/models/product.dart';

class Campaign {
  int id;
  DateTime startDate;
  DateTime endDate;
  int status;
  DateTime exp;
  Product product;
  int quantity;
  Campaign(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.exp,
      required this.product,
      required this.quantity});
  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
        id: json['id'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        status: json['status'],
        exp: json['exp'],
        product: json['product'],
        quantity: json['quantity']);
  }
  // "campaignDetails": [
  //   {
  //     "id": 1,
  //     "dateApply": "2023-06-28T09:14:45.687",
  //     "percentDiscount": 20,
  //     "discount": 34.327,
  //     "minQuantity": 1
  //   },
  //   {
  //     "id": 2,
  //     "dateApply": "2023-07-07T09:16:01.35",
  //     "percentDiscount": 40,
  //     "discount": 25.745,
  //     "minQuantity": 1
  //   }
  // ]
}

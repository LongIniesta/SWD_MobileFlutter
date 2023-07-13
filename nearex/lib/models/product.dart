import 'package:nearex/models/category.dart';

class Product {
  int id;
  int price;
  String origin;
  String productImg;
  String productName;
  String description;
  String unit;
  int netWeight;
  Category? category;

  // "storeId": 3,
  // "code": "10617961",
  // "status": 1,
  // "store": {
  //   "id": 3,
  //   "storeName": "WinMart",
  //   "phone": "0247106686",
  //   "address": "Tầng 5, Mplaza SaiGon, 39 Lê Duẩn, Phường Bến Nghé, Quận 1, Thành Phố Hồ Chí Minh",
  //   "logo": "winmart",
  //   "token": null,
  //   "passwordHash": "2qTfPWkHjyDOWLfLnu6G0JwQHsxNEHlxbkeRPbmBSFMFogRzDo8gNxDmaS/weAlGtoqyxwEHU3/CIg+/+1L8YQ==",
  //   "passwordSalt": "o594Iqtlq12DBkbVSYihYzNMbbCMH0dRyXwFKPzfVfBj604/LtssTZMrN8PhbrfPpkY5WvhsIFkj6ANVpT/TGptce5kCyrbXZEGqRCa0WddXpEdLdd0E6/FoQZV6O7RjDtEbIy4at6tDOI339iKUTcugD5L8x4mdXdhUNCq4ljQ=",
  //   "coordinateString": null
  // }
  Product(
      {required this.id,
      required this.price,
      required this.origin,
      required this.productImg,
      required this.productName,
      required this.description,
      required this.unit,
      required this.netWeight});

  factory Product.fromJson(Map<String, dynamic> json) {
    double price = json['price'] * 1000;
    return Product(
        id: json['id'],
        price: price.toInt(),
        origin: json['origin'],
        productImg: json['productImg'],
        productName: json['productName'],
        description: json['description'],
        unit: json['unit'],
        netWeight: json['netWeight']);
  }
}

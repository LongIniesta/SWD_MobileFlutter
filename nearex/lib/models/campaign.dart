import 'package:nearex/models/product.dart';

class Campaign {
  int id;
  DateTime startDate;
  DateTime endDate;
  int status;
  DateTime exp;
  Product product;
  int quantity;
  int minQuantity;
  int discountPrice;
  Campaign(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.exp,
      required this.product,
      required this.quantity,
      required this.discountPrice,
      required this.minQuantity});
  factory Campaign.fromJson(Map<String, dynamic> json) {
    DateTime startDate = DateTime.parse(json['startDate']);
    DateTime endDate = DateTime.parse(json['endDate']);
    DateTime exp = DateTime.parse(json['exp']);
    int discountPrice = json['product']['price'];
    int minQuantity = 1;
    var campaignDetailsJson = json['campaignDetails'];
    for (int i = campaignDetailsJson.length - 1; i >= 0; i--) {
      Map<String, dynamic> campaignDetailJson = campaignDetailsJson[i];
      DateTime dateApply = DateTime.parse(campaignDetailJson['dateApply']);
      if (dateApply.isBefore(DateTime.now())) {
        discountPrice = campaignDetailJson['discount'];
        minQuantity = campaignDetailJson['minQuantity'];
        break;
      }
    }
    return Campaign(
        id: json['id'],
        startDate: startDate,
        endDate: endDate,
        status: json['status'],
        exp: exp,
        product: Product.fromJson(json['product']),
        quantity: json['quantity'],
        discountPrice: discountPrice,
        minQuantity: minQuantity);
  }
}

// class CampaignDetails {
//   int id;
//   DateTime dateApply;
//   int percentDiscount;
//   int discount;
//   int minQuantity;
//   CampaignDetails(
//       {required this.id,
//       required this.dateApply,
//       required this.percentDiscount,
//       required this.discount,
//       required this.minQuantity});
//   factory CampaignDetails.fromJson(Map<String, dynamic> json) {
//     return CampaignDetails(
//         id: json['id'],
//         dateApply: json['dateApply'],
//         percentDiscount: json['percentDiscount'],
//         discount: json['discount'],
//         minQuantity: json['minQuantity']);
//   }
// }

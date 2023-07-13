import 'package:intl/intl.dart';
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
  // List<CampaignDetails> campaignDetails;
  Campaign(
      {required this.id,
      required this.startDate,
      required this.endDate,
      required this.status,
      required this.exp,
      required this.product,
      required this.quantity,
      required this.discountPrice,
      required this.minQuantity
      // required this.campaignDetails
      });
  factory Campaign.fromJson(Map<String, dynamic> json) {
    String dateFormat = "yyyy-MM-dd";
    DateTime startDate = DateFormat(dateFormat).parse(json['startDate']);
    DateTime endDate = DateFormat(dateFormat).parse(json['endDate']);
    DateTime exp = DateFormat(dateFormat).parse(json['exp']);
    double discountPrice = json['product']['price'] * 1000;
    int minQuantity = 1;
    var campaignDetailsJson = json['campaignDetails'];
    for (int i = campaignDetailsJson.length - 1; i >= 0; i--) {
      Map<String, dynamic> campaignDetailJson = campaignDetailsJson[i];
      DateTime dateApply =
          DateFormat(dateFormat).parse(campaignDetailJson['dateApply']);
      if (dateApply.isAfter(DateTime.now())) {
        discountPrice = campaignDetailJson['discount'] * 1000;
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
        discountPrice: discountPrice.toInt(),
        minQuantity: minQuantity
        // campaignDetails: CampaignDetails.fromJson(json['campaignDetails'])
        );
  }
}

class CampaignDetails {
  int id;
  DateTime dateApply;
  int percentDiscount;
  int discount;
  int minQuantity;
  CampaignDetails(
      {required this.id,
      required this.dateApply,
      required this.percentDiscount,
      required this.discount,
      required this.minQuantity});
  factory CampaignDetails.fromJson(Map<String, dynamic> json) {
    return CampaignDetails(
        id: json['id'],
        dateApply: json['dateApply'],
        percentDiscount: json['percentDiscount'],
        discount: json['discount'],
        minQuantity: json['minQuantity']);
  }
}

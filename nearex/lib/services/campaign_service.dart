import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/campaign.dart';

class CampaignService {
  static Future<List<Campaign>> getCampaigns(
      {int? page,
      int? pageSize,
      DateTime? exp,
      DateTime? startDate,
      int? productId,
      String? productName,
      int? status}) async {
    List<Campaign> campaigns = [];
    Map<String, String> parameters = {};
    if (page != null) parameters['Page'] = page.toString();
    if (pageSize != null) parameters['PageSize'] = pageSize.toString();
    if (startDate != null) parameters['StartDate'] = startDate.toString();
    if (status != null) parameters['Status'] = status.toString();
    if (exp != null) parameters['Exp'] = exp.toString();
    if (productId != null) parameters['ProductId'] = productId.toString();
    if (productName != null) parameters['ProductName'] = productName;
    Uri uri =
        Uri.https('swd-nearex.azurewebsites.net', '/api/campaigns', parameters);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      var campaignsJson = jsonDecode(response.body)['results'];
      for (final campaign in campaignsJson) {
        campaigns.add(Campaign.fromJson(campaign));
      }
    }
    return campaigns;
  }

  static Future<List<Campaign>> getCampaignsByCategory(
      {int? page, int? pageSize, required int categoryId}) async {
    List<Campaign> campaigns = [];
    Map<String, String> parameters = {'cateId': categoryId.toString()};
    if (page != null) parameters['Page'] = page.toString();
    if (pageSize != null) parameters['PageSize'] = pageSize.toString();
    Uri uri = Uri.https(
        'swd-nearex.azurewebsites.net', '/api/campaigns/cate', parameters);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      var campaignsJson = jsonDecode(response.body)['results'];
      for (final campaign in campaignsJson) {
        campaigns.add(Campaign.fromJson(campaign));
      }
    }
    return campaigns;
  }

  static Future<Campaign?> getCampaignById(int campaignId) async {
    Campaign? campaign;
    Uri uri = Uri.parse(
        "https://swd-nearex.azurewebsites.net/api/campaigns/$campaignId");
    Response response = await get(uri);
    if (response.statusCode == 200) {
      campaign = Campaign.fromJson(jsonDecode(response.body));
    }
    return campaign;
  }
}

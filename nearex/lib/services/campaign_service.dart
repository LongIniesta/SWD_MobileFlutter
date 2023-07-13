import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/campaign.dart';

class CampaignService {
  static Future<List<Campaign>> _getCampaigns(
      Map<String, String>? parameters) async {
    List<Campaign> campaigns = [];
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

  static Future<List<Campaign>> getCampaigns(int page, int pageSize) async {
    Map<String, String> parameters = {
      "Page": page.toString(),
      'PageSize': pageSize.toString()
    };
    return _getCampaigns(parameters);
  }

  static Future<List<Campaign>> getCampaignsByEndDate(
      int page, int pageSize, DateTime endDate) async {
    Map<String, String> parameters = {
      "Page": page.toString(),
      'PageSize': pageSize.toString(),
      'EndDate': endDate.toString()
    };
    return _getCampaigns(parameters);
  }

  static Future<List<Campaign>> getCampaignsByCategory(
      int page, int pageSize, int categoryId) async {
    List<Campaign> campaigns = [];
    Map<String, String> parameters = {
      "Page": page.toString(),
      'PageSize': pageSize.toString(),
      'cateId': categoryId.toString()
    };
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

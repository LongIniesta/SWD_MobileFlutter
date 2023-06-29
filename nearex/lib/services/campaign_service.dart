import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/campaign.dart';

class CampaignService {
  static Future<List<Campaign>> getCampaigns(int page, int pageSize) async {
    List<Campaign> campaigns = [];
    Map<String, String> parameters = {
      "Page": page.toString(),
      'PageSize': pageSize.toString()
    };
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
      int page, int pageSize, int categoryId) async {
    List<Campaign> campaigns = [];
    Map<String, String> parameters = {
      "Page": page.toString(),
      'PageSize': pageSize.toString(),
      'cateId': categoryId.toString()
    };
    Uri uri = Uri.https(
        'swd-nearex.azurewebsites.net', '/cate/api/campaigns', parameters);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      var campaignsJson = jsonDecode(response.body)['results'];
      for (final campaign in campaignsJson) {
        campaigns.add(Campaign.fromJson(campaign));
      }
    }
    return campaigns;
  }
}

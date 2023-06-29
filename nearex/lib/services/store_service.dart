import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/store.dart';

class StoreService {
  static Future<List<Store>> getStores(int page, int pageSize) async {
    List<Store> stores = [];
    Map<String, String> parameters = {
      'Page': page.toString(),
      'PageSize': pageSize.toString()
    };
    Uri uri =
        Uri.https('swd-nearex.azurewebsites.net', '/api/stores', parameters);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      var storesJson = jsonDecode(response.body)['results'];
      for (final store in storesJson) {
        stores.add(Store(
            id: store['id'],
            storeName: store['storeName'],
            phone: store['phone'],
            address: store['address'],
            logo: store['logo'],
            token: store['token'],
            coordinateString: store['coordinateString']));
      }
    } else {}
    return stores;
  }
}

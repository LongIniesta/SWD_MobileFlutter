import 'dart:convert';

import 'package:http/http.dart';
import 'package:nearex/models/category.dart';

class CategoryService {
  static Future<List<Category>> getCategories() async {
    List<Category> categories = [];
    Map<String, String> parameters = {
      'Page': '1',
      'PageSize': '20',
      'SortType': '2'
    };
    Uri uri = Uri.https(
        'swd-nearex.azurewebsites.net', '/api/categories', parameters);
    Response response = await get(uri);
    for (var categoryJson in jsonDecode(response.body)) {
      categories.add(Category(id: categoryJson['id'], name: 'categoryName'));
    }
    return categories;
  }
}

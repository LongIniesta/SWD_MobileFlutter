class CategoryProduct {
  int? id;
  String? categoryName;

  CategoryProduct({this.id, this.categoryName});

  CategoryProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['categoryName'] = categoryName;
    return data;
  }
}

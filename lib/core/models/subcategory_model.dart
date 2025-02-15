import 'package:fruit_market/core/models/product_model.dart';

class SubCategoryModel {
  String? name;
  String? id;
  String? categoryName;
  List<ProductModel>? products;
  SubCategoryModel(
      {required this.name,
      this.id,
      required this.categoryName,
      required this.products});
  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    categoryName = json['categoryName'];
    if (json['products'] != null) {
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['id'] = id;
    data['categoryName'] = categoryName;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

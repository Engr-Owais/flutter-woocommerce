import 'package:mvvm/model/category.dart';

class ProductsModel {
  ProductsModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.categories,
      required this.stockStatus,
      required this.stockQuantity});

  ProductsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    stockQuantity = json['stock_quantity'];
    stockStatus = json['stock_status'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(CategoryModel.fromJson(v));
      });
    }
  }
  late int id;
  late String name;
  late String price;
  late List<CategoryModel> categories;
  late String stockStatus;
  late int stockQuantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    map['stock_quantity'] = stockQuantity;
    if (categories != null) {
      map['categories'] = categories.map((v) => v.toJson()).toList();
    }
    map['stock_status'] = stockStatus;
    return map;
  }
}

class CategoryModel {
  CategoryModel({required this.id, required this.name, required this.parent});

  CategoryModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    parent = json['parent'];
  }
  int? id;
  String? name;
  int? parent;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['parent'] = parent;

    return map;
  }
}

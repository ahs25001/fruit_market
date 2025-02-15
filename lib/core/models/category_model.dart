class CategoryModel {
  final String name;
  //  String? id;
  // final Strnig

  CategoryModel({required this.name});
  CategoryModel.fromJson(Map<String, dynamic> json)
      : name = json['name'];
  Map<String, dynamic> toJson() => {'name': name};
}

class ProductModel {
  String? id;
  String? name;
  String? price;
  String? categoryName;
  String? subCategoryName;
  String? discription;
  List<String?>? nutrition;
  String? image;
  double?rating;
  ProductModel(
      {this.id,
      this.name,
      this.rating,
      this.price,
      this.categoryName,
      this.subCategoryName,
      this.discription,
      this.nutrition,
      this.image});
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    rating = json["rating"];
    name = json["name"];
    discription = json["discription"];
    nutrition = json["nutrition"];
    categoryName = json["categoryName"];
    subCategoryName = json["subCategoryName"];
    price = json["price"];
    image = json["image"];
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'rating': rating,
        'price': price,
        'subCategoryName': subCategoryName,
        'image': image,
        'categoryName': categoryName,
        'discription': discription,
        'nutrition': nutrition
      };
}

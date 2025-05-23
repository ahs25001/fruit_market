class FavoriteModel {
  String? id;
  String? uid;
  String? name;
  String? price;
  num? quntitiy;
  String ? categoryName;
  String ? subcategoryId;
  String? image;
  num? rating;
  FavoriteModel(
      {this.id,
       this.subcategoryId,
      this.name,
       this.categoryName,
      this.rating,
      this.price,
      this.quntitiy,
      required this.uid,
      this.image});
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    categoryName = json["categoryName"];
    subcategoryId = json["subcategoryId"];
    uid = json["uid"];
    rating = json["rating"];
    name = json["name"];
    quntitiy = json["quntitiy"];
    price = json["price"];
    image = json["image"];
  }
  Map<String, dynamic> toJson() => {
        'id': id,
        'subcategoryId': subcategoryId,
        'name': name,
        'categoryName': categoryName,
        'uid': uid,
        'rating': rating,
        'price': price,
        'image': image,
        'quntitiy': quntitiy
      };
}

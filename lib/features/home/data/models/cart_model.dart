class CartModel {
  String? id;
  String? uid;
  String? name;
  String? price;
  num? rating;
  num? quntitiy;
  String? categoryName;
  String ? subcategoryId;
  String? image;
  CartModel(
      {this.name,
      this.rating,
      this.subcategoryId,
      this.id,
      this.categoryName,
      this.price,
      this.quntitiy,
       this.uid,
      this.image});
  CartModel.fromJson(Map<String, dynamic> json) {
    categoryName = json["categoryName"];
    uid = json["uid"];
    name = json["name"];
    rating = json["rating"];
    subcategoryId = json["subcategoryId"];
    id = json["id"];
    quntitiy = json["quntitiy"];
    price = json["price"];
    image = json["image"];
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'categoryName': categoryName,
        'subcategoryId': subcategoryId,
        'id': id,
        'uid': uid,
        'price': price,
        'image': image,
        'rating': rating,
        'quntitiy': quntitiy
      };
}

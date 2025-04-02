class CartModel {
  String? uid;
  String? name;
  String? price;
  num? quntitiy;
  String? categoryName;
  String? image;
  CartModel(
      {
      this.name,
      this.categoryName,
      this.price,
      this.quntitiy,
      required this.uid,
      this.image});
  CartModel.fromJson(Map<String, dynamic> json) {
    categoryName = json["categoryName"];
    uid = json["uid"];
    name = json["name"];
    quntitiy = json["quntitiy"];
    price = json["price"];
    image = json["image"];
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'categoryName': categoryName,
        'uid': uid,
        'price': price,
        'image': image,
        'quntitiy': quntitiy
      };
}

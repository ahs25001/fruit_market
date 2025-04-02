class CartModel {
  String? id;
  String? uid;
  String? name;
  String? price;
  num? quntitiy;
  String? categoryName;
  String? image;
  CartModel(
      {this.name,
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
    id = json["id"];
    quntitiy = json["quntitiy"];
    price = json["price"];
    image = json["image"];
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'categoryName': categoryName,
        'id': id,
        'uid': uid,
        'price': price,
        'image': image,
        'quntitiy': quntitiy
      };
}

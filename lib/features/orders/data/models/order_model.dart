import 'package:fruit_market/features/home/data/models/cart_model.dart';

class OrderModel {
   String? id;
  // final String name;
  final String uid;
  // final String image;
  final List<CartModel> products;
  final num totalPrice;
  final num dateInMilleSeconds;
  OrderModel(
      {this.id,
      required this.uid,
      // required this.name,
      // required this.image,
      required this.products,
      required this.totalPrice,
      required this.dateInMilleSeconds});
  OrderModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          // name: json['name'],
          uid: json['uid'],
          // image: json['image'],
          products: List<CartModel>.from(
              json['products'].map((x) => CartModel.fromJson(x))),
          totalPrice: json['totalPrice'],
          dateInMilleSeconds: json['dateInMilleSeconds'],
        );
  Map<String, dynamic> toJson() => {
        'id': id,
        // 'name': name,
        'uid': uid,
        // 'image': image,
        'products': List<dynamic>.from(products.map((x) => x.toJson())),
        'totalPrice': totalPrice,
        'dateInMilleSeconds': dateInMilleSeconds,
      };
}

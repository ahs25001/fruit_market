import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/auth/data/models/user_model.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/home/data/models/favorite_model.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';

class FirebaseFirestoreManager {
  static FirebaseFirestoreManager? _instance;

  static FirebaseFirestoreManager get instance {
    _instance ??= FirebaseFirestoreManager();
    return _instance!;
  }

  Future<UserModel?> getUser(String id) async {
    var doc =
        await FirebaseFirestore.instance.collection('Users').doc(id).get();
    return UserModel.fromJson(doc.data()!);
  }

  Future<void> addUser(UserModel userModel) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userModel.id)
        .set(userModel.toJson());
  }

  Future<void> addSubcategory(SubCategoryModel subcategory) async {
    var doc = FirebaseFirestore.instance.collection('Subcategories').doc();

    subcategory.id = doc.id;
    await doc.set(subcategory.toJson());
  }

  Future<List<SubCategoryModel>> getSubcategories(String category) async {
    var doc = await FirebaseFirestore.instance
        .collection('Subcategories')
        .where("categoryName", isEqualTo: category)
        .get();
    return doc.docs.map((e) => SubCategoryModel.fromJson(e.data())).toList();
  }

  Future<void> addProduct(ProductModel product) async {
    var productDoc = FirebaseFirestore.instance.collection('Products').doc();

    product.id = productDoc.id;
    await productDoc.set(product.toJson());
    QuerySnapshot<Map<String, dynamic>> subCategorySnapshot =
        await FirebaseFirestore.instance
            .collection("Subcategories")
            .where("name", isEqualTo: product.subCategoryName)
            .get();

    SubCategoryModel subcategory =
        SubCategoryModel.fromJson(subCategorySnapshot.docs.first.data());
    subcategory.products!.add(product);
    await FirebaseFirestore.instance
        .collection("Subcategories")
        .doc(subcategory.id)
        .update(subcategory.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteList() {
    return FirebaseFirestore.instance
        .collection("Favorites")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  void addProductToFavorite(FavoriteModel model) async {
    var favoriteProductDoc = FirebaseFirestore.instance
        .collection("Favorites")
        .doc("${model.id}${currentUser?.id}");
    await favoriteProductDoc.set(model.toJson());
  }

  void removeProductFromFavorite(String modelId) async {
    var favoriteProductDoc = FirebaseFirestore.instance
        .collection("Favorites")
        .doc("$modelId${currentUser?.id}");
    await favoriteProductDoc.delete();
  }

  void updateFavoriteProduct(FavoriteModel newProduct) {
    var favoriteProductDoc = FirebaseFirestore.instance
        .collection("Favorites")
        .doc("${newProduct.id}${currentUser?.id}");
    favoriteProductDoc.update(newProduct.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCart() {
    return FirebaseFirestore.instance
        .collection("Cart")
        .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }

  void addProductToCart(CartModel model) async {
    var favoriteProductDoc = FirebaseFirestore.instance
        .collection("Cart")
        .doc("${model.id}${currentUser?.id}");
    await favoriteProductDoc.set(model.toJson());
  }

  void removeProductFromCart(String modelId) async {
    var cartProductDoc = FirebaseFirestore.instance
        .collection("Cart")
        .doc("$modelId${currentUser?.id}");
    await cartProductDoc.delete();
  }

  void updateCart(CartModel newCart) {
    var favoriteProductDoc = FirebaseFirestore.instance
        .collection("Cart")
        .doc("${newCart.id}${currentUser?.id}");
    favoriteProductDoc.update(newCart.toJson());
  }

  void addOrder(OrderModel model) async {
    var orderDoc = FirebaseFirestore.instance.collection("Orders").doc();
    model.id = orderDoc.id;
    await orderDoc.set(model.toJson());
  }

  Future<List<OrderModel>> getOrders() async {
    var doc = await FirebaseFirestore.instance
        .collection("Orders")
        .where("uid", isEqualTo: currentUser?.id)
        .get();
    return doc.docs.map((e) => OrderModel.fromJson(e.data())).toList();
  }

  Future<void> changeRating(CartModel cartProduct, String orderId) async {
    var subcategoryDoc = await FirebaseFirestore.instance
        .collection('Subcategories')
        .doc(cartProduct.subcategoryId)
        .get();
    var orderDoc = await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderId)
        .get();
    OrderModel orderModel = OrderModel.fromJson(orderDoc.data()!);
    for (var productInOrder in orderModel.products) {
      if (productInOrder.id == cartProduct.id) {
        productInOrder.rating = cartProduct.rating;
      }
    }
    await FirebaseFirestore.instance
        .collection("Orders")
        .doc(orderId)
        .update(orderModel.toJson());
    SubCategoryModel subcategory =
        SubCategoryModel.fromJson(subcategoryDoc.data()!);
    num newRating = 0;
    for (var product in subcategory.products ?? []) {
      if (product.id == cartProduct.id) {
        newRating = ((cartProduct.rating ?? 0) + (product.rating ?? 0)) / 2;
        product.rating = newRating;

        break;
      }
    }
    await FirebaseFirestore.instance
        .collection("Subcategories")
        .doc(cartProduct.subcategoryId)
        .update(subcategory.toJson());
  }
}

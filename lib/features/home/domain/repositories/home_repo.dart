import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/auth/data/models/user_model.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/home/data/models/favorite_model.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';

abstract class HomeRepo {
  Future<Either<Errors, List<SubCategoryModel>>> getSubCategories(
      String category);
  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteList();
  Future<Either<Errors, void>> addProductToFavoriteList(
      ProductModel? productModel,String subcategoryId);
  Future<Either<Errors, void>> removeProductFromFavoriteList(String modelId);
  Future<Either<Errors, void>> updateFavoriteProduct(
      FavoriteModel productModel);
  Future<Either<Errors, void>> addProductToCart(CartModel cartModel);
  Stream<QuerySnapshot<Map<String, dynamic>>> getCart();
  Future<Either<Errors, void>> removeProductFromCart(String modelId);
  Future<Either<Errors, void>> updateCart(CartModel cartModel);
  Future<Either<Errors, UserModel?>> getUser(String id);
  Future<Either<Errors, void>> placeOrders(OrderModel order);
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/home/data/models/favorite_model.dart';
import 'package:fruit_market/features/home/domain/repositories/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  @override
  Future<Either<Errors, List<SubCategoryModel>>> getSubCategories(
      String category) async {
    try {
      List<SubCategoryModel> subCategories =
          await firebaseFirestoreManager.getSubcategories(category);
      return Right(subCategories);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteList() {
    return firebaseFirestoreManager.getFavoriteList();
  }

  @override
  Future<Either<Errors, void>> addProductToFavoriteList(
      ProductModel? productModel) async {
    try {
      FavoriteModel model = FavoriteModel(
          id: productModel?.id,
          categoryName: productModel?.categoryName,
          image: productModel?.image,
          uid: FirebaseAuth.instance.currentUser!.uid,
          name: productModel?.name,
          price: productModel?.price,
          quntitiy: 1,
          rating: productModel?.rating);
      firebaseFirestoreManager.addProductToFavorite(model);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, void>> removeProductFromFavoriteList(
      String modelId) async {
    try {
      firebaseFirestoreManager.removeProductFromFavorite(modelId);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, void>> updateFavoriteProduct(
      FavoriteModel productModel) async {
    try {
      firebaseFirestoreManager.updateFavoriteProduct(productModel);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, void>> addProductToCart(CartModel cartModel) async {
    try {
      firebaseFirestoreManager.addProductToCart(cartModel);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getCart() {
    return firebaseFirestoreManager.getCart();
  }

  @override
  Future<Either<Errors, void>> removeProductFromCart(String modelId) async {
    try {
      firebaseFirestoreManager.removeProductFromCart(modelId);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, void>> updateCart(CartModel cartModel) async {
    try {
      firebaseFirestoreManager.updateCart(cartModel);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }
}

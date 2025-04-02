import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/models/product_model.dart';
import 'package:fruit_market/core/models/subcategory_model.dart';
import 'package:fruit_market/features/home/data/models/favorite_model.dart';

abstract class HomeRepo {
  Future<Either<Errors, List<SubCategoryModel>>> getSubCategories(
      String category);
 Stream<QuerySnapshot<Map<String, dynamic>>> getFavoriteList();
  Future<Either<Errors, void>> addProductToFavoriteList(
      ProductModel? productModel);
  Future<Either<Errors, void>> removeProductFromFavoriteList(
      String modelId);
      Future<Either<Errors,void>> updateFavoriteProduct(FavoriteModel productModel);

}

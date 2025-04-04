import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/products_details/domain/repositories/product_details_repo.dart';

class ProductDetailsRepoImpl extends ProductDetailsRepo {
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
   Future<Either<Errors, void>> removeProductFromCart(String modelId) async {
    try {
      firebaseFirestoreManager.removeProductFromCart(modelId);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

}
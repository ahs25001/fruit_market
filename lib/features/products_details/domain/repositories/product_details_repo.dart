import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';

abstract class ProductDetailsRepo{
  Future<Either<Errors, void>> addProductToCart(CartModel cartModel);
  Future<Either<Errors, void>> removeProductFromCart(String modelId);
}
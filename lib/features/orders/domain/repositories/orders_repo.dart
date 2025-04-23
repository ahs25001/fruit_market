import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';

abstract class OrdersRepo {
  Future<Either<Errors, List<OrderModel>>> getOrders();
  Future <Either<Errors, void>> changeRating(CartModel cartProduct,String orderId);
}

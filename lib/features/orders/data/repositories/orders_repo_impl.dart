import 'package:dartz/dartz.dart';
import 'package:fruit_market/core/errors/errors.dart';
import 'package:fruit_market/core/utils/app_constants.dart';
import 'package:fruit_market/features/home/data/models/cart_model.dart';
import 'package:fruit_market/features/orders/data/models/order_model.dart';
import 'package:fruit_market/features/orders/domain/repositories/orders_repo.dart';

class OrdersRepoImpl extends OrdersRepo {
  @override
  Future<Either<Errors, List<OrderModel>>> getOrders() async {
    try {
      var data = await firebaseFirestoreManager.getOrders();
      return Right(data);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }

  @override
  Future<Either<Errors, void>> changeRating(CartModel cartProduct,String orderId)async {
    try {
      await firebaseFirestoreManager.changeRating(cartProduct,orderId);
      return Right(null);
    } catch (e) {
      return Left(RemoteError(massage: e.toString()));
    }
  }
}
